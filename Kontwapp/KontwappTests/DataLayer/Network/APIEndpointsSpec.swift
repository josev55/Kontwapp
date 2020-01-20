//
//  APIEndpointsSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class APIEndpointsSpec: XCTestCase {
    func testGetCounters() {
        let result = APIEndpoints.getCounters(query: nil)
        
        XCTAssert(result.path == "/counters")
        XCTAssert(result.method == .get)
    }
    
    func testAddCounter() {
        let result = APIEndpoints.addCounter(title: "")
        
        XCTAssert(result.path == "/counter")
        XCTAssert(result.method == .post)
    }
    
    func testDeleteCounter() {
        let result = APIEndpoints.deleteCounter(id: "")
        
        XCTAssert(result.path == "/counter")
        XCTAssert(result.method == .delete)
    }
    
    func testIncrementCounter() {
        let result = APIEndpoints.incrementCounter(id: "")
        
        XCTAssert(result.path == "/counter/inc")
        XCTAssert(result.method == .post)
    }
    
    func testDecrementCounter() {
        let result = APIEndpoints.decrementCounter(id: "")
        
        XCTAssert(result.path == "/counter/dec")
        XCTAssert(result.method == .post)
    }
}
