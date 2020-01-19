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
    public var headerParamaters: [String: String]
    public var bodyParamaters: [String: Any]
    
    init(path: String,
         method: HTTPMethodType = .get,
         queryParameters: [String: Any] = [:],
         headerParamaters: [String: String] = [:],
         bodyParamaters: [String: Any] = [:]) {
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.headerParamaters = headerParamaters
        self.bodyParamaters = bodyParamaters
    }
    
    func asUrlRequest(with config: NetworkConfigurable) -> URLRequest {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var allHeaders: [String: String] = config.headers
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
        
        request.allHTTPHeaderFields = allHeaders
        
        if !queryParameters.isEmpty {
            let urlComponents = URLComponents(url: config.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
            var queryItems = [URLQueryItem]()
            queryParameters.forEach { (arg) in
                let (key, value) = arg
                queryItems.append(URLQueryItem(name: key, value: value as? String))
            }
            request.url = urlComponents?.url
        }
        
        if !bodyParamaters.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParamaters)
        }
        
        
        return request
    }
}
