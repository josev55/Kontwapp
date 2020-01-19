//
//  AddCounterView.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

protocol AddCounterView {
    func counterDidSave(counters: [CounterViewModel])
    func counterDidNotSave()
}
