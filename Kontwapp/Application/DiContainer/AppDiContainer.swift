//
//  AppDiContainer.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

final class AppDiContainer {
    func makeCountersDiContainer() -> CounterDiContainer {
        return CounterDiContainer()
    }
}
