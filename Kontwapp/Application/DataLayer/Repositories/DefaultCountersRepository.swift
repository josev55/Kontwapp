//
//  DefaultCountersRepository.swift
//  DataLayer
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

final class DefaultCountersRepository {
    private let serviceClient: ServiceClient
    
    init(serviceClient: ServiceClient){
        self.serviceClient = serviceClient
    }
}

extension DefaultCountersRepository: CountersRepository {
    func incrementCounter(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask {
        return serviceClient.request(with: APIEndpoints.incrementCounter(id: id), completion: completion)
    }
    
    func decrementCounter(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask {
        return serviceClient.request(with: APIEndpoints.decrementCounter(id: id), completion: completion)
    }
    
    func addCounter(title: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask {
        return serviceClient.request(with: APIEndpoints.addCounter(title: title), completion: completion)
    }
    
    func getCounters(completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask {
        return serviceClient.request(with: APIEndpoints.getCounters(query: nil), completion: completion)
    }
    
    func deleteCounter(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask {
        return serviceClient.request(with: APIEndpoints.deleteCounter(id: id), completion: completion)
    }
}
