//
//  CountersRepository.swift
//  DomainLayer
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

public protocol CountersRepository {
    @discardableResult
    func getCounters(completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask
    
    @discardableResult
    func addCounter(title: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask
}
