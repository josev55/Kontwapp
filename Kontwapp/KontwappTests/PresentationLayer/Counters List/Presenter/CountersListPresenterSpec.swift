//
//  CountersListPresenterSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class CountersListPresenterSpec: XCTestCase {
    var countersListPresenterSuccess: CountersListPresenter!
    var countersListPresenterFail: CountersListPresenter!
    var fetchUseCaseSuccess: FetchCountersUseCase!
    var fetchUseCaseFail: FetchCountersUseCase!
    var incrementUseCaseSuccess: IncrementCounterUseCase!
    var incrementUseCaseFail: IncrementCounterUseCase!
    var decrementUseCaseSuccess: DecrementCounterUseCase!
    var decrementUseCaseFail: DecrementCounterUseCase!
    var deleteUseCaseSuccess: DeleteCounterUseCase!
    var deleteUseCaseFail: DeleteCounterUseCase!
    var counterListView: CountersListViewMock!
    
    override func setUp() {
        fetchUseCaseSuccess = FetchCountersUseCaseSuccess()
        fetchUseCaseFail = FetchCountersUseCaseFail()
        incrementUseCaseSuccess = IncrementCounterUseCaseSuccess()
        incrementUseCaseFail = IncrementCounterUseCaseFail()
        decrementUseCaseSuccess = DecrementCounterUseCaseSuccess()
        decrementUseCaseFail = DecrementCounterUseCaseFail()
        deleteUseCaseSuccess = DeleteCounterUseCaseSuccess()
        deleteUseCaseFail = DeleteCounterUseCaseFail()
        countersListPresenterSuccess = DefaultCountersListPresenter(fetchCountersUseCase: fetchUseCaseSuccess, incrementCounterUseCase: incrementUseCaseSuccess, decrementCounterUseCase: decrementUseCaseSuccess, deleteCounterUseCase: deleteUseCaseSuccess)
        countersListPresenterFail = DefaultCountersListPresenter(fetchCountersUseCase: fetchUseCaseFail, incrementCounterUseCase: incrementUseCaseFail, decrementCounterUseCase: decrementUseCaseFail, deleteCounterUseCase: deleteUseCaseFail)
        
        counterListView = CountersListViewMock()
        countersListPresenterSuccess.countersListView = counterListView
        countersListPresenterFail.countersListView = counterListView
    }
    
    func testFetchCountersSuccess() {
        countersListPresenterSuccess.fetchCounters()
        XCTAssertTrue(counterListView.didCallSetCounterList)
    }
    
    func testFetchCountersFail() {
        countersListPresenterFail.fetchCounters()
        XCTAssertTrue(counterListView.didCallShowError)
    }
    
    func testIncrementCounterSuccess() {
        countersListPresenterSuccess.incrementCounter(id: "")
        XCTAssertTrue(counterListView.didCallSetCounterList)
    }
    
    func testIncrementCounterFail() {
        countersListPresenterFail.incrementCounter(id: "")
        XCTAssertTrue(counterListView.didCallUpdateCounterValueDidFail)
    }
    
    func testDecrementCounterSuccess() {
        countersListPresenterSuccess.decrementCounter(id: "")
        XCTAssertTrue(counterListView.didCallSetCounterList)
    }
    
    func testDecrementCounterFail() {
        countersListPresenterFail.decrementCounter(id: "")
        XCTAssertTrue(counterListView.didCallUpdateCounterValueDidFail)
    }
    
    func testDeleteCounterSuccess() {
        countersListPresenterSuccess.deleteCounter(id: "")
        XCTAssertTrue(counterListView.didCallDeleteCounterSucceed)
    }
    
    func testDeleteCounterFail() {
        countersListPresenterFail.deleteCounter(id: "")
        XCTAssertTrue(counterListView.didCallDeleteCounterDidFail)
    }
}

class FetchCountersUseCaseSuccess: FetchCountersUseCase {
    func execute(completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.success(nil))
    }
}

class FetchCountersUseCaseFail: FetchCountersUseCase {
    func execute(completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.failure(NetworkError.error(statusCode: 500, data: nil)))
    }
}

class IncrementCounterUseCaseSuccess: IncrementCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.success(nil))
    }
}

class IncrementCounterUseCaseFail: IncrementCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.failure(NetworkError.error(statusCode: 500, data: nil)))
    }
}

class DecrementCounterUseCaseSuccess: DecrementCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.success(nil))
    }
}

class DecrementCounterUseCaseFail: DecrementCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.failure(NetworkError.error(statusCode: 500, data: nil)))
    }
}

class DeleteCounterUseCaseSuccess: DeleteCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.success(nil))
    }    
}

class DeleteCounterUseCaseFail: DeleteCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.failure(NetworkError.error(statusCode: 500, data: nil)))
    }
}

class CountersListViewMock: CountersListView {
    var didCallSetCounterList: Bool = false
    var didCallUpdateCounterValueDidFail: Bool = false
    var didCallShowError: Bool = false
    var didCallDeleteCounterSucceed: Bool = false
    var didCallDeleteCounterDidFail: Bool = false
    
    func setCountersList(countersList: [CounterViewModel]) {
        didCallSetCounterList = true
    }
    
    func updateCounterValueDidFail() {
        didCallUpdateCounterValueDidFail = true
    }
    
    func showError() {
        didCallShowError = true
    }
    
    func deleteCounterSucceed(id: String, counters: [CounterEntity]) {
        didCallDeleteCounterSucceed = true
    }
    
    func deleteCounterdidFail() {
        didCallDeleteCounterDidFail = true
    }
    
    
}
