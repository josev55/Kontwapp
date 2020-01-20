//
//  IncrementCounterUseCaseSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class IncrementCounterUseCaseSpec: XCTestCase {
    var successRepository: DefaultCountersRepository!
    var failRepository: DefaultCountersRepository!
    
    override func setUp() {
        successRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        failRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
    }
    
    func testIncrementCounterSuccess() {
        let expectation = XCTestExpectation(description: "Expect to increment counter succesfully")
        let incrementCounterUseCase = DefaultIncrementCounterUseCase(repository: successRepository)
        
        incrementCounterUseCase.execute(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testIncrementCounterFail() {
        let expectation = XCTestExpectation(description: "Expect to fail to increment counter")
        let incrementCounterUseCase = DefaultIncrementCounterUseCase(repository: failRepository)
        
        incrementCounterUseCase.execute(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .failure( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
