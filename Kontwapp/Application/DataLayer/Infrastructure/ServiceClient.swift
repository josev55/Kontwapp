//
//  CounterService.swift
//  DataLayer
//
//  Created by Jose Vildosola on 18-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

public enum ServiceStatus<T> {
    case success(_ data: T?)
    case failure(_ error: NetworkError)
}

protocol ServiceClient {
    typealias CompletionHandler<T> = (ServiceStatus<T>) -> Void
    func request<T: Decodable>(with endpoint: Endpoint, completion: @escaping CompletionHandler<T>) -> URLSessionDataTask
}

class DefaultServiceClient: ServiceClient {
    private let config: NetworkConfigurable
    
    public init(config: NetworkConfigurable) {
        self.config = config
    }
    
    func request<T: Decodable>(with endpoint: Endpoint, completion: @escaping CompletionHandler<T>) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: endpoint.asUrlRequest(with: config)) { (data, response, error) in
            if let requestError = error {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                completion(.failure(error))
            } else {
                let model = try? JSONDecoder().decode(T.self, from: data!)
                completion(.success(model))
            }
        }
        task.resume()
        return task
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}
