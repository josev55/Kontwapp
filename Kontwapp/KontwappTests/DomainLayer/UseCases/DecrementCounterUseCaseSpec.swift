//
//  DecrementCounterUseCaseSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class DecrementCounterUseCaseSpec: XCTestCase {
    var successRepository: DefaultCountersRepository!
    var failRepository: DefaultCountersRepository!
    
    override func setUp() {
        successRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        failRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
    }
    
    func testDecrementCounterSuccess() {
        let expectation = XCTestExpectation(description: "Expect to decrement counter succesfully")
        let decrementCounterUseCase = DefaultDecrementCounterUseCase(repository: successRepository)
        
        decrementCounterUseCase.execute(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDecrementCounterFail() {
        let expectation = XCTestExpectation(description: "Expect to fail to decrement counter")
        let decrementCounterUseCase = DefaultDecrementCounterUseCase(repository: failRepository)
        
        decrementCounterUseCase.execute(id: "") { (serviceStatus) in
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
