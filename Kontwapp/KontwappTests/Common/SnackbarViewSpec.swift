//
//  SnackBarViewSpec.swift
//
//  Created by Jose Vildosola on 9/4/19.
//  Copyright © 2019 Jose Vildosola. All rights reserved.
//

import XCTest
@testable import Kontwapp

class SnackBarViewSpec: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testInitSnackBarForSuccessType() {
        let snackBarView = SnackbarView(frame: CGRect.zero, snackbarType: .Success, message: "SUCCESS_MESSAGE")
        let expectedImage = UIImage(named: "success", in: Bundle.main, compatibleWith: nil)
        XCTAssertNotNil(snackBarView.contentView)
        XCTAssert(snackBarView.subviews.count == 1)
        XCTAssert(snackBarView.iconImageView.image! == expectedImage!)
    }
    
    func testInitSnackBarForFailureType() {
        let snackBarView = SnackbarView(frame: CGRect.zero, snackbarType: .Failure, message: "FAILURE_MESSAGE")
        let expectedImage = UIImage(named: "failure", in: Bundle.main, compatibleWith: nil)
        XCTAssertNotNil(snackBarView.contentView)
        XCTAssert(snackBarView.subviews.count == 1)
        XCTAssert(snackBarView.iconImageView.image! == expectedImage!)
    }
    
    func testHandleGestureStateEnded() {
        let snackBarView = SnackbarView(frame: CGRect.zero, snackbarType: .Success, message: "SUCCESS_MESSAGE")
        let panGesture = UIPanGestureRecognizer(target: nil, action: nil)
        
        panGesture.state = .ended
        snackBarView.handlePan(gestureRecognizer: panGesture)
        
        XCTAssert(snackBarView.contentView.frame.origin.y == -90)
    }
    
    func testHandleGestureStateBegan() {
        let snackBarView = SnackbarView(frame: CGRect.zero, snackbarType: .Success, message: "SUCCESS_MESSAGE")
        let panGesture = UIPanGestureRecognizer(target: nil, action: nil)
        panGesture.state = .began
        
        snackBarView.addGestureRecognizer(panGesture)
        snackBarView.handlePan(gestureRecognizer: panGesture)
        
        XCTAssert(panGesture.translation(in: UIApplication.shared.keyWindow) == CGPoint.zero)
    }
}
