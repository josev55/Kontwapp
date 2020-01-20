//
//  DeleteCounterUseCase.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class DeleteCounterUseCaseSpec: XCTestCase {
    var successRepository: DefaultCountersRepository!
    var failRepository: DefaultCountersRepository!
    
    override func setUp() {
        successRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        failRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
    }
    
    func testDeleteCounterSuccess() {
        let expectation = XCTestExpectation(description: "Expect to delete a counter succesfully")
        let deleteCounterUseCase = DefaultDeleteCounterUseCase(repository: successRepository)
        
        deleteCounterUseCase.execute(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDeleteCounterFail() {
        let expectation = XCTestExpectation(description: "Expect to fail delete a counter")
        let deleteCounterUseCase = DefaultDeleteCounterUseCase(repository: failRepository)
        
        deleteCounterUseCase.execute(id: "") { (serviceStatus) in
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
