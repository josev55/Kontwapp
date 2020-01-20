//
//  DeleteCounterUseCase.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 20-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

protocol DeleteCounterUseCase {
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void)
}

class DefaultDeleteCounterUseCase: DeleteCounterUseCase {
    private let countersRepository: CountersRepository!
    
    init(repository: CountersRepository) {
        self.countersRepository = repository
    }
    
    func execute(id: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        countersRepository.deleteCounter(id: id, completion: completion)
    }
}
