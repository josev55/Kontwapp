
//
//  AppDiContainerSpec.swift
//  KontwappTests
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class AppDiContainerSpec: XCTestCase {
    var container: AppDiContainer!
    override func setUp() {
        container = AppDiContainer()
    }
    
    func testMakeCounterDiContainer() {
        let result = container.makeCountersDiContainer()
        
        XCTAssertNotNil(result, "Result was nil")
    }
}
