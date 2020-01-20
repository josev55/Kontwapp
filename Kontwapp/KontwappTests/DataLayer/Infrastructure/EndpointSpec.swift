//
//  EndpointSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class EndpointSpec: XCTestCase {
    var getEndpoint: Endpoint!
    let config = ApiDataNetworkConfig(baseURL: URL(string: "http://sometests.com")!)
    
    override func setUp() {
        getEndpoint = Endpoint(path: "/test")
    }

    func testGetEndpointURLRequest() {
        let result = getEndpoint.asUrlRequest(with: config)
        
        XCTAssert(result.httpMethod == "GET")
        XCTAssert(result.httpBody == nil)
    }
    
    func testEndpointWithQueryParams() {
        getEndpoint = Endpoint(path: "/test", method: .get, queryParameters: ["title": "some text"], headerParameters: [:], bodyParameters: [:])
        let components = URLComponents(url: getEndpoint.asUrlRequest(with: config).url!, resolvingAgainstBaseURL: false)
        
        let result = components?.queryItems?.filter({ (item) -> Bool in
            item.name == "title"
        }).first
        
        XCTAssertNotNil(result)
    }
    
    func testEndpointWithBodyParams() {
        getEndpoint = Endpoint(path: "/test", method: .get, queryParameters: [:], headerParameters: [:], bodyParameters: ["title": "some text"])
        let result = getEndpoint.asUrlRequest(with: config)
        
        XCTAssertNotNil(result.httpBody)
    }
}
