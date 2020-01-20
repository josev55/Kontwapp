//
//  DefaultCountersRepositorySpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class DefaultCountersRepositorySpec: XCTestCase {
    var countersRepository: CountersRepository!
    override func setUp() {
    }
    
    func testCounterRepositoryGetCountersSuccess() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        let expectation = XCTestExpectation(description: "Expect to complete succesfully")
        countersRepository.getCounters { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testCountersRepositoryGetCountersFailure() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
        let expectation = XCTestExpectation(description: "Expect error")
        countersRepository.getCounters { (serviceStatus) in
            switch serviceStatus {
            case .failure( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryDeleteCounterSuccess() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        let expectation = XCTestExpectation(description: "Expect to succesfully delete counter")
        countersRepository.deleteCounter(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryDeleteCounterFailure() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
        let expectation = XCTestExpectation(description: "Expect to succesfully delete counter")
        countersRepository.deleteCounter(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .failure( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryAddCounterSuccess() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        let expectation = XCTestExpectation(description: "Expect to add a counter")
        countersRepository.addCounter(title: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryAddCounterFailure() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
        let expectation = XCTestExpectation(description: "Expect to fail adding a counter")
        countersRepository.addCounter(title: "") { (serviceStatus) in
            switch serviceStatus {
            case .failure( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryIncrementCounterSuccess() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        let expectation = XCTestExpectation(description: "Expect to increment a counter")
        countersRepository.incrementCounter(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryIncrementCounterFail() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
        let expectation = XCTestExpectation(description: "Expect to fail to increment a counter")
        countersRepository.incrementCounter(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .failure( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryDecrementCounterSuccess() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockSuccess())
        let expectation = XCTestExpectation(description: "Expect to decrement a counter")
        countersRepository.decrementCounter(id: "") { (serviceStatus) in
            switch serviceStatus {
            case .success( _):
                expectation.fulfill()
            default:
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCountersRepositoryDecrementCounterFail() {
        countersRepository = DefaultCountersRepository(serviceClient: ServiceClientMockFail())
        let expectation = XCTestExpectation(description: "Expect to fail to decrement a counter")
        countersRepository.decrementCounter(id: "") { (serviceStatus) in
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

class ServiceClientMockSuccess: ServiceClient {
    func request<T>(with endpoint: Endpoint, completion: @escaping (ServiceStatus<T>) -> Void) -> URLSessionDataTask where T : Decodable {
        completion(.success(nil))
        return URLSessionDataTask()
    }
}

class ServiceClientMockFail: ServiceClient {
    func request<T>(with endpoint: Endpoint, completion: @escaping (ServiceStatus<T>) -> Void) -> URLSessionDataTask where T : Decodable {
        completion(.failure(NetworkError.error(statusCode: 500, data: nil)))
        return URLSessionDataTask()
    }
}
