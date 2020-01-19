//
//  CountersTableViewController.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

public class CountersTableViewController: UITableViewController {

    let noCountersView = UINib(nibName: "NoCountersView", bundle: Bundle.main).instantiate(withOwner: self(), options: nil) as! NoCountersView
    public static func create(viewControllerFactory: MakeCountersTableViewControllerFactory) -> UIViewController {
        let viewController = CountersTableViewController.instantiate(from: .Counters)
        viewController.makeCountersTableViewControllerFactory = viewControllerFactory
        return viewController
    }
    
    private var makeCountersTableViewControllerFactory: MakeCountersTableViewControllerFactory!
    
    var countersDataSource = [CounterViewModel]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        countersDataSource.append(CounterViewModel(title: "Some Text", currentValue: 0))
        setLayout()
    }
    
    private func setLayout() {
        title = "Counters List"
        let addCounterButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCounter))
        addCounterButton.tintColor = Color.primary
        self.navigationItem.rightBarButtonItem = addCounterButton
    }
    
    @objc private func addCounter() {
        self.navigationController?.modalPresentationStyle = .overCurrentContext
        
        let addCounterViewController = makeCountersTableViewControllerFactory.makeAddCounterViewController()
        let navController = UINavigationController(rootViewController: addCounterViewController)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countersDataSource.count == 0 {
            self.tableView.addSubview(UIView())
        }
        return countersDataSource.count
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CounterTableViewCell
        let counterData = countersDataSource[indexPath.row]
        
        cell.counterTitle.text = counterData.title
        cell.counterValueLabel.text = String(counterData.currentValue)
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            countersDataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}

public protocol MakeCountersTableViewControllerFactory {
    func makeAddCounterViewController() -> UIViewController
}

extension CountersTableViewController: CountersListView {
    func setCountersList(countersList: [CounterViewModel]) {
        self.countersDataSource = countersList
        self.tableView.reloadData()
    }
}
