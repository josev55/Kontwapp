//
//  CounterDiContainerSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class CounterDiContainerSpec: XCTestCase {
    var container: CounterDiContainer!
    let dependencies = CounterDiContainer.Dependencies(serviceClient: ServiceClientMock())
    override func setUp() {
        container = CounterDiContainer(dependencies: dependencies)
    }
    
    func testMakeCountersRepository() {
        let result = container.makeCountersRepository()
        
        XCTAssert(type(of: result) == DefaultCountersRepository.self)
    }
    
    func testMakeFetchCountersUseCase() {
        let result = container.makeFetchCountersUseCase()
        
        XCTAssert(type(of: result) == DefaultFetchUseCase.self)
    }
    
    func testMakeAddCounterUseCase() {
        let result = container.makeAddCounterUseCase()
        
        XCTAssert(type(of: result) == DefaultAddCounterUseCase.self)
    }
    
    func testMakeIncrementCounterUseCase() {
        let result = container.makeIncrementCounterUseCase()
        
        XCTAssert(type(of: result) == DefaultIncrementCounterUseCase.self)
    }
    
    func testMakeDecrementCounterUseCase() {
        let result = container.makeDecrementCounterUseCase()
        
        XCTAssert(type(of: result) == DefaultDecrementCounterUseCase.self)
    }
    
    func testMakeDeleteCounterUseCase() {
        let result = container.makeDeleteCounterUseCase()
        
        XCTAssert(type(of: result) == DefaultDeleteCounterUseCase.self)
    }
    
    func testMakeCountersListPresenter() {
        let result = container.makeCountersListPresenter()
        
        XCTAssert(type(of: result) == DefaultCountersListPresenter.self)
    }
    
    func testMakeAddCounterPresenter() {
        let result = container.makeAddCounterPresenter()
        
        XCTAssert(type(of: result) == DefaultAddCounterPresenter.self)
    }
    
    func testMakeCountersTableViewController() {
        let result = container.makeCounterTableViewController()
        
        XCTAssert(type(of: result) == CountersTableViewController.self)
    }
    
    func testMakeAddCounterViewController() {
        let result = container.makeAddCounterViewController(countersDelegate: nil)
        
        XCTAssert(type(of: result) == AddCounterViewController.self)
    }
}

class ServiceClientMock: ServiceClient {
    func request<T>(with endpoint: Endpoint, completion: @escaping (ServiceStatus<T>) -> Void) -> URLSessionDataTask where T : Decodable {
        return URLSession.shared.dataTask(with: URL(string: "http://somefakeurl.com")!)
    }
}
