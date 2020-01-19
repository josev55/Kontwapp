//
//  AppStoryboard.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

public enum AppStoryboard: String {
    case Counters
    
    private var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle(identifier: "com.jv.PresentationLayer"))
    }
    
    public func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as T.Type).storyboardId
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}
