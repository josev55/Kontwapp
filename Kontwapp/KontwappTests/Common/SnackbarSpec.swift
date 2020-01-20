//
//  SnackbarSpec.swift
//
//  Created by Jose Vildosola on 9/4/19.
//  Copyright © 2019 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class SnackbarSpec: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShowSnackBar() {
        let window = UIApplication.shared.keyWindow
        Snackbar.show(.Success, message: "")
        
        let result = window?.subviews.contains(where: { (view) -> Bool in
            view.isKind(of: SnackbarView.self)
        })
        
        XCTAssert(result == true)
    }
}

