//
//  CountersListPresenter.swift
//  Kontwapp
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

protocol CountersListPresenter {
    var countersListView: CountersListView? { get set }
    func fetchCounters()
}

final class DefaultCountersListPresenter: CountersListPresenter {
    var countersListView: CountersListView?
    
    private let fetchCountersUseCase: FetchCountersUseCase!
    
    
    init(fetchCountersUseCase: FetchCountersUseCase) {
        self.fetchCountersUseCase = fetchCountersUseCase
    }
    
    func fetchCounters() {
        fetchCountersUseCase.execute { (serviceStatus) in
            switch serviceStatus {
            case .success(let counters):
                let viewModels = counters?.map({ (counterEntity) -> CounterViewModel in
                    return CounterViewModel(title: counterEntity.title, currentValue: counterEntity.count)
                })
                self.countersListView?.setCountersList(countersList: viewModels ?? [])
            case .failure( _):
                self.countersListView?.showError()
            }
        }
    }
}
