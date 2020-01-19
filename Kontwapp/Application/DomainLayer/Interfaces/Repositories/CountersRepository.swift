//
//  CountersRepository.swift
//  DomainLayer
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation
import DataLayer

public protocol CountersRepository {
    @discardableResult
    func getCounters(completion: (ServiceStatus<[CounterEntity]>) -> Void) -> URLSessionDataTask
}
