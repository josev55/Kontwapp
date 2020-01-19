//
//  APIEndpoint.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

final class APIEndpoints {
    static func getCounters(query: String?) -> Endpoint {
        return Endpoint(path: "/counters")
    }
}
