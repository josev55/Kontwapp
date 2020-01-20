//
//  CountersTableViewController.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

class CountersTableViewController: UITableViewController {

    static func create(presenter: CountersListPresenter, viewControllerFactory: MakeCountersTableViewControllerFactory) -> UIViewController {
        let viewController = CountersTableViewController.instantiate(from: .Counters)
        viewController.makeCountersTableViewControllerFactory = viewControllerFactory
        viewController.countersListPresenter = presenter
        return viewController
    }
    
    private var makeCountersTableViewControllerFactory: MakeCountersTableViewControllerFactory!
    private var countersListPresenter: CountersListPresenter!
    private let noCountersView = UINib(nibName: "NoCountersView", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as? NoCountersView
    
    var countersDataSource = [CounterViewModel]()
    var loadingIndicatorManager = LoadingIndicatorManager()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
        loadingIndicatorManager.addLoadingMessage("Loading", view: self.view)
        countersListPresenter.fetchCounters()
    }
    
    private func setLayout() {
        title = "Counters List"
        let addCounterButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCounter))
        addCounterButton.tintColor = Color.primary
        self.navigationItem.rightBarButtonItem = addCounterButton
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        
        self.refreshControl = refresh
    }
    
    @objc private func refreshList() {
        
        countersListPresenter.fetchCounters()
    }
    
    @objc private func addCounter() {
        self.navigationController?.modalPresentationStyle = .overCurrentContext
        
        let addCounterViewController = makeCountersTableViewControllerFactory.makeAddCounterViewController(countersDelegate: self)
        let navController = UINavigationController(rootViewController: addCounterViewController)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    private func addNoCountersView() {
        noCountersView?.frame = tableView.frame
        self.tableView.addSubview(noCountersView ?? UIView())
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countersDataSource.count == 0 {
            addNoCountersView()
        }
        return countersDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CounterTableViewCell
        let counterData = countersDataSource[indexPath.row]
        
        cell.fillCell(counter: counterData)
        cell.valueUpdated = { [weak self] didIncrement in
            guard let strongSelf = self else { return }
            strongSelf.loadingIndicatorManager.addLoadingMessage("Updating counter value", view: strongSelf.view)
            if didIncrement {
                strongSelf.countersListPresenter.incrementCounter(id: counterData.id)
            } else {
                strongSelf.countersListPresenter.decrementCounter(id: counterData.id)
            }
        }
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = self.countersDataSource[indexPath.row]
            DispatchQueue.main.async {
                self.loadingIndicatorManager.addLoadingMessage("Deleting counter", view: self.view)
            }
            self.countersListPresenter.deleteCounter(id: item.id)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

protocol MakeCountersTableViewControllerFactory {
    func makeAddCounterViewController(countersDelegate: CountersDelegate?) -> UIViewController
}

extension CountersTableViewController: CountersListView {
    func deleteCounterSucceed(id: String, counters: [CounterEntity]) {
        let counterIdx = countersDataSource.firstIndex { (counter) -> Bool in
            counter.id == id
        }
        DispatchQueue.main.async {
            self.loadingIndicatorManager.removeLoadingIndicator()
            if let idx = counterIdx {
                self.countersDataSource.remove(at: idx)
                self.tableView.deleteRows(at: [IndexPath(row: idx, section: 0)], with: .bottom)
            }
        }
    }
    
    func deleteCounterdidFail() {
        DispatchQueue.main.async {
            self.loadingIndicatorManager.removeLoadingIndicator()
            Snackbar.show(.Failure, message: "Failed to delete counter")
        }
    }
    
    func updateCounterValueDidFail() {
        DispatchQueue.main.async {
            self.loadingIndicatorManager.removeLoadingIndicator()
            Snackbar.show(.Failure, message: "There was a problem updating counter value")
        }
    }
    
    func setCountersList(countersList: [CounterViewModel]) {
        self.countersDataSource = countersList
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.noCountersView?.removeFromSuperview()
            self.loadingIndicatorManager.removeLoadingIndicator()
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.loadingIndicatorManager.removeLoadingIndicator()
            Snackbar.show(.Failure, message: "There was a problem retrieving counters")
        }
    }
}

extension CountersTableViewController: CountersDelegate {
    func updateCounters(counters: [CounterViewModel]) {
        self.countersDataSource = counters
        DispatchQueue.main.async {
            self.noCountersView?.removeFromSuperview()
            self.tableView.reloadData()
        }
    }
}
