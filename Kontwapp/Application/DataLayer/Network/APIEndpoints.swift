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
    
    static func addCounter(title: String) -> Endpoint {
        return Endpoint(path: "/counter", method: .post, queryParameters: [:], headerParameters: [:], bodyParameters: ["title": title])
    }
    
    static func incrementCounter(id: String) -> Endpoint {
        return Endpoint(path: "/counter/inc", method: .post, queryParameters: [:], headerParameters: [:], bodyParameters: ["id": id])
    }
    
    static func decrementCounter(id: String) -> Endpoint {
        return Endpoint(path: "/counter/dec", method: .post, queryParameters: [:], headerParameters: [:], bodyParameters: ["id": id])
    }
    
    static func deleteCounter(id: String) -> Endpoint {
        return Endpoint(path: "/counter", method: .delete, queryParameters: [:], headerParameters: [:], bodyParameters: ["id": id])
    }
}
