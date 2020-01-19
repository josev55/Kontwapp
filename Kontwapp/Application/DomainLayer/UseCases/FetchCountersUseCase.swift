//
//  FetchCountersUseCase.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

protocol FetchCountersUseCase {
    func execute(completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void)
}

final class DefaultFetchUseCase: FetchCountersUseCase {
    private let countersRepository: CountersRepository!
    
    init(countersRepository: CountersRepository) {
        self.countersRepository = countersRepository
    }
    
    func execute(completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        countersRepository.getCounters(completion: completion)
    }
}
