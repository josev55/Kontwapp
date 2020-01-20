//
//  CounterDiContainer.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

final class CounterDiContainer {
    struct Dependencies {
        let serviceClient: ServiceClient
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeCountersRepository() -> CountersRepository {
        return DefaultCountersRepository(serviceClient: dependencies.serviceClient)
    }
    
    func makeFetchCountersUseCase() -> FetchCountersUseCase {
        return DefaultFetchUseCase(countersRepository: makeCountersRepository())
    }
    
    func makeIncrementCounterUseCase() -> IncrementCounterUseCase {
        return DefaultIncrementCounterUseCase(repository: makeCountersRepository())
    }
    
    func makeDecrementCounterUseCase() -> DecrementCounterUseCase {
        return DefaultDecrementCounterUseCase(repository: makeCountersRepository())
    }
    
    func makeDeleteCounterUseCase() -> DeleteCounterUseCase {
        return DefaultDeleteCounterUseCase(repository: makeCountersRepository())
    }
    
    func makeCountersListPresenter() -> CountersListPresenter {
        return DefaultCountersListPresenter(fetchCountersUseCase: makeFetchCountersUseCase(), incrementCounterUseCase: makeIncrementCounterUseCase(), decrementCounterUseCase: makeDecrementCounterUseCase(), deleteCounterUseCase: makeDeleteCounterUseCase())
    }
    
    func makeCounterTableViewController() -> UIViewController {
        var presenter = makeCountersListPresenter()
        let viewController = CountersTableViewController.create(presenter: presenter, viewControllerFactory: self)
        presenter.countersListView = viewController as? CountersListView
        return viewController
    }
    
    func makeAddCounterUseCase() -> AddCounterUseCase {
        return DefaultAddCounterUseCase(repository: makeCountersRepository())
    }
    
    func makeAddCounterPresenter() -> AddCounterPresenter {
        return DefaultAddCounterPresenter(addCounterUseCase: makeAddCounterUseCase())
    }
    
    func makeAddCounterViewController(countersDelegate: CountersDelegate?) -> UIViewController {
        var presenter = makeAddCounterPresenter()
        let viewController = AddCounterViewController.create(countersDelegate: countersDelegate, addCounterPresenter: presenter)
        presenter.addCounterView = viewController as? AddCounterView
        return viewController
    }
    
    
}

extension CounterDiContainer: MakeCountersTableViewControllerFactory {}
