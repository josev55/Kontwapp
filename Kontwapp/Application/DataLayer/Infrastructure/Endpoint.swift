//
//  Endpoint.swift
//  DataLayer
//
//  Created by Jose Vildosola on 18-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

class Endpoint {
    public var path: String
    public var method: HTTPMethodType
    public var queryParameters: [String: Any]
    public var headerParameters: [String: String]
    public var bodyParameters: [String: Any]
    
    init(path: String,
         method: HTTPMethodType = .get,
         queryParameters: [String: Any] = [:],
         headerParameters: [String: String] = [:],
         bodyParameters: [String: Any] = [:]) {
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.headerParameters = headerParameters
        self.bodyParameters = bodyParameters
    }
    
    func asUrlRequest(with config: NetworkConfigurable) -> URLRequest {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var allHeaders: [String: String] = config.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
        
        request.allHTTPHeaderFields = allHeaders
        
        if !queryParameters.isEmpty {
            var urlComponents = URLComponents(url: config.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
            var queryItems = [URLQueryItem]()
            queryParameters.forEach { (arg) in
                let (key, value) = arg
                queryItems.append(URLQueryItem(name: key, value: value as? String))
            }
            urlComponents?.queryItems = queryItems
            request.url = urlComponents?.url
        }
        
        if !bodyParameters.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        }
        
        
        return request
    }
}
