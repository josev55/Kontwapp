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
        let config = ApiDataNetworkConfig(baseURL: URL(string: "http://localhost:3000/api/v1")!, headers: ["Cache-Control": "no-cache"], queryParameters: [:])
        let dependencies = CounterDiContainer.Dependencies(serviceClient: DefaultServiceClient(config: config))
        return CounterDiContainer(dependencies: dependencies)
    }
}
