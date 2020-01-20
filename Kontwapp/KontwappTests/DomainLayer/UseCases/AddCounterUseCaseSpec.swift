//
//  AddCounterUseCaseSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class AddCounterUseCaseSpec: XCTestCase {
    var successRepository: DefaultCountersRepository!
    var failRepository: DefaultCountersRepository!
    override func setUp() {
        successRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        failRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
    }
    
    func testAddCounterSuccess() {
        let expectation = XCTestExpectation(description: "Expect to add counter succesfully")
        let addCounterUseCase = DefaultAddCounterUseCase(repository: successRepository)
        
        addCounterUseCase.execute(counterTitle: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testAddCounterFail() {
        let expectation = XCTestExpectation(description: "Expect to fail to add counter")
        let addCounterUseCase = DefaultAddCounterUseCase(repository: failRepository)
        
        addCounterUseCase.execute(counterTitle: "") { (serviceStatus) in
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
