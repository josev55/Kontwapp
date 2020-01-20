//
//  FetchCountersUseCase.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class FetchCountersUseCaseSpec: XCTestCase {

    var successRepository: DefaultCountersRepository!
    var failRepository: DefaultCountersRepository!
    override func setUp() {
        successRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        failRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
    }
    
    func testGetCountersSuccess() {
        let expectation = XCTestExpectation(description: "Expect to get counters")
        let fetchUseCase = DefaultFetchUseCase(countersRepository: successRepository)
        
        fetchUseCase.execute { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCountersFail() {
        let expectation = XCTestExpectation(description: "Expect to fail getting counters")
        let fetchUseCase = DefaultFetchUseCase(countersRepository: failRepository)
        
        fetchUseCase.execute { (serviceStatus) in
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
