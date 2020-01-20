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
    func incrementCounter(id: String)
    func decrementCounter(id: String)
    func deleteCounter(id: String)
}

final class DefaultCountersListPresenter: CountersListPresenter {
    var countersListView: CountersListView?
    
    private let fetchCountersUseCase: FetchCountersUseCase!
    private let incrementCounterUseCase: IncrementCounterUseCase!
    private let decrementCounterUseCase: DecrementCounterUseCase!
    private let deleteCounterUseCase: DeleteCounterUseCase!
    
    init(fetchCountersUseCase: FetchCountersUseCase,
         incrementCounterUseCase: IncrementCounterUseCase,
         decrementCounterUseCase: DecrementCounterUseCase,
         deleteCounterUseCase: DeleteCounterUseCase) {
        self.fetchCountersUseCase = fetchCountersUseCase
        self.incrementCounterUseCase = incrementCounterUseCase
        self.decrementCounterUseCase = decrementCounterUseCase
        self.deleteCounterUseCase = deleteCounterUseCase
    }
    
    func fetchCounters() {
        fetchCountersUseCase.execute { (serviceStatus) in
            switch serviceStatus {
            case .success(let counters):
                let viewModels = counters?.map({ (counterEntity) -> CounterViewModel in
                    return CounterViewModel(id: counterEntity.id, title: counterEntity.title, currentValue: counterEntity.count)
                })
                self.countersListView?.setCountersList(countersList: viewModels ?? [])
            case .failure( _):
                self.countersListView?.showError()
            }
        }
    }
    
    func incrementCounter(id: String) {
        incrementCounterUseCase.execute(id: id) { (serviceStatus) in
            switch serviceStatus {
            case .success(let counters):
                self.countersListView?.setCountersList(countersList: self.mapCountersToModel(counters: counters) ?? [])
            case .failure( _):
                self.countersListView?.updateCounterValueDidFail()
            }
        }
    }
    
    func decrementCounter(id: String) {
        decrementCounterUseCase.execute(id: id) { (serviceStatus) in
            switch serviceStatus {
            case .success(let counters):
                self.countersListView?.setCountersList(countersList: self.mapCountersToModel(counters: counters) ?? [])
            case .failure( _):
                self.countersListView?.updateCounterValueDidFail()
            }
        }
    }
    
    func deleteCounter(id: String) {
        deleteCounterUseCase.execute(id: id) { (serviceStatus) in
            switch serviceStatus {
            case .success(let counters):
                self.countersListView?.deleteCounterSucceed(id: id, counters: counters ?? [])
                print("Success")
            case .failure( _):
                self.countersListView?.deleteCounterdidFail()
                print("Failure")
            }
        }
    }
    
    private func mapCountersToModel(counters: [CounterEntity]?) -> [CounterViewModel]? {
        return counters?.map({ (counter) -> CounterViewModel in
            return CounterViewModel(id: counter.id, title: counter.title, currentValue: counter.count)
        })
    }
}
