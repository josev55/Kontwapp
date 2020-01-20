//
//  AddCounterPresenter.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

protocol AddCounterPresenter {
    var addCounterView: AddCounterView? { get set }
    func addCounter(title: String)
}

final class DefaultAddCounterPresenter: AddCounterPresenter {
    var addCounterView: AddCounterView?
    
    private let addCounterUseCase: AddCounterUseCase!
    
    init(addCounterUseCase: AddCounterUseCase) {
        self.addCounterUseCase = addCounterUseCase
    }
    
    func addCounter(title: String) {
        addCounterUseCase.execute(counterTitle: title) { (serviceStatus) in
            switch serviceStatus {
            case .success(let counters):
                let models = counters?.map({ (counter) -> CounterViewModel in
                    return CounterViewModel(id: counter.id,title: counter.title, currentValue: counter.count)
                })
                self.addCounterView?.counterDidSave(counters: models ?? [])
            case .failure( _):
                self.addCounterView?.counterDidNotSave()
            }
        }
    }
}
