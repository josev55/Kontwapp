//
//  IncrementCounterUseCase.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

protocol IncrementCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void)
}

class DefaultIncrementCounterUseCase: IncrementCounterUseCase {
    private let countersRepository: CountersRepository!
    
    init(repository: CountersRepository) {
        self.countersRepository = repository
    }
    
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        countersRepository.incrementCounter(id: id, completion: completion)
    }
}
