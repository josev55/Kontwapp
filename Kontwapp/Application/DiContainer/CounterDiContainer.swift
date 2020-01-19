//
//  CounterDiContainer.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation
import PresentationLayer

final class CounterDiContainer {
    func makeCounterTableViewController() -> UIViewController {
        return CountersTableViewController.create(viewControllerFactory: self)
    }
    
    func makeAddCounterViewController() -> UIViewController {
        return AddCounterViewController.instantiate(from: .Counters)
    }
}

extension CounterDiContainer: MakeCountersTableViewControllerFactory {}
