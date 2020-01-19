//
//  Snackbar.swift
//
//  Created by José Vildósola on 8/29/19.
//  Copyright © 2019 José Vildósola. All rights reserved.
//

import UIKit

enum SnackbarType {
    case Success
    case Failure
}

class Snackbar {
    static var instance: SnackbarView?
    static var reuseTimer: Timer?
    
    static func show(_ type: SnackbarType, message: String) {
        
        if Snackbar.instance != nil {
            Snackbar.instance?.removeFromSuperview()
            Snackbar.reuseTimer?.invalidate()
        }
        
        let window = UIApplication.shared.keyWindow!
        let frame = calculateFrameFromKeyWindow(window)
        let snackview = SnackbarView(frame: frame, snackbarType: type, message: message)
        snackview.isUserInteractionEnabled = true
        Snackbar.instance = snackview
        
        let delay = type == .Success ? 4 : 6
        
        window.addSubview(snackview)
        let topSafeAreaY = window.safeAreaInsets.top
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            snackview.frame = CGRect(x: 16, y: topSafeAreaY + 12, width: snackview.frame.size.width, height: 82)
        }, completion: { _ in
            snackview.setNeedsLayout()
            snackview.layoutIfNeeded()
            Snackbar.reuseTimer = Timer.scheduledTimer(timeInterval: TimeInterval(delay), target: self, selector: #selector(dismissSnackbar), userInfo: nil, repeats: false)
        })
    }
    
    @objc static func dismissSnackbar() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            Snackbar.instance!.frame = CGRect(x: 8, y: -84, width: Snackbar.instance!.frame.size.width, height: 82)
        }, completion: { _ in
            Snackbar.instance!.removeFromSuperview()
            Snackbar.reuseTimer?.invalidate()
        })
    }
    
    private static func calculateFrameFromKeyWindow(_ window: UIWindow) -> CGRect {
        let width = window.frame.size.width
        return CGRect(x: 16, y: -60, width: width - 32, height: 82)
    }
}
