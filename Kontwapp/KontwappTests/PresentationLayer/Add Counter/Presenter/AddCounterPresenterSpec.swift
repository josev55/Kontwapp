//
//  AddCounterPresenterSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class AddCounterPresenterSpec: XCTestCase {
    var addCounterUseCaseSuccess: AddCounterUseCase!
    var addCounterUseCaseFail: AddCounterUseCase!
    var addCounterPresenterSuccess: AddCounterPresenter!
    var addCounterPresenterFail: AddCounterPresenter!
    var addCounterView: AddCounterViewMock!
    override func setUp() {
        addCounterUseCaseSuccess = AddCounterUseCaseSuccess()
        addCounterUseCaseFail = AddCounterUseCaseFail()
        addCounterView = AddCounterViewMock()
        addCounterPresenterSuccess = DefaultAddCounterPresenter(addCounterUseCase: addCounterUseCaseSuccess)
        addCounterPresenterSuccess.addCounterView = addCounterView
        addCounterPresenterFail = DefaultAddCounterPresenter(addCounterUseCase: addCounterUseCaseFail)
        addCounterPresenterFail.addCounterView = addCounterView
    }
    
    func testAddCounterSuccess() {
        addCounterPresenterSuccess.addCounter(title: "")
        XCTAssertTrue(addCounterView.didCallCounterDidSave)
    }
    
    func testAddCounterFail() {
        addCounterPresenterFail.addCounter(title: "")
        XCTAssertTrue(addCounterView.didCallCounterDidNotSave)
    }
}

class AddCounterUseCaseSuccess: AddCounterUseCase {
    func execute(counterTitle: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.success([CounterEntity(id: "123", title: "Some", count: 1)]))
    }
}

class AddCounterUseCaseFail: AddCounterUseCase {
    func execute(counterTitle: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        completion(.failure(NetworkError.error(statusCode: 500, data: nil)))
    }
}

class AddCounterViewMock: AddCounterView {
    var didCallCounterDidSave: Bool = false
    var didCallCounterDidNotSave: Bool = false
    func counterDidSave(counters: [CounterViewModel]) {
        didCallCounterDidSave = true
    }
    
    func counterDidNotSave() {
        didCallCounterDidNotSave = true
    }
    
    
}
