//
//  AddCounterUseCase.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

protocol AddCounterUseCase {
    func execute(counterTitle: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void)
}

final class DefaultAddCounterUseCase: AddCounterUseCase {
    private let countersRepository: CountersRepository!
    
    init(repository: CountersRepository) {
        countersRepository = repository
    }
    
    func execute(counterTitle: String, completion: @escaping (ServiceStatus<[CounterEntity]>) -> Void) {
        countersRepository.addCounter(title: counterTitle, completion: completion)
    }
}
