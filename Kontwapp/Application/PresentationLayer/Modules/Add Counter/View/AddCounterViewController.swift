//
//  AddCounterViewController.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 18-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

protocol CountersDelegate {
    func updateCounters(counters: [CounterViewModel])
}

public class AddCounterViewController: UIViewController {
    static func create(countersDelegate: CountersDelegate?, addCounterPresenter: AddCounterPresenter) -> UIViewController {
        let viewController = AddCounterViewController.instantiate(from: .Counters)
        viewController.delegate = countersDelegate
        viewController.presenter = addCounterPresenter
        return viewController
    }
    @IBOutlet weak var addCounterButton: UIButton!
    @IBOutlet weak var counterTitleLabel: UITextField!
    
    
    private var delegate: CountersDelegate?
    private var presenter: AddCounterPresenter!
    private let loadingManager = LoadingIndicatorManager()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    private func setLayout() {
        title = "Add Counter"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModal))
        doneButton.tintColor = Color.primary
        self.navigationItem.rightBarButtonItem = doneButton
        
        addCounterButton.backgroundColor = Color.secondary
        addCounterButton.tintColor = .white
        addCounterButton.layer.cornerRadius = 4.0
    }
    
    @objc private func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addCounterTapped(_ sender: Any) {
        loadingManager.addLoadingMessage("Saving counter", view: self.view)
        presenter.addCounter(title: counterTitleLabel.text ?? "")
    }
}

extension AddCounterViewController: AddCounterView {
    func counterDidSave(counters: [CounterViewModel]) {
        delegate?.updateCounters(counters: counters)
        DispatchQueue.main.async {
            self.loadingManager.removeLoadingIndicator()
            self.dismissModal()
        }
    }
    
    func counterDidNotSave() {
        Snackbar.show(.Failure, message: "Could not save counter")
        DispatchQueue.main.async {
            self.loadingManager.removeLoadingIndicator()
        }
    }
}
