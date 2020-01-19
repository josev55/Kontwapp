//
//  AddCounterViewController.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 18-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

public class AddCounterViewController: UIViewController {
    
    @IBOutlet weak var addCounterButton: UIButton!
    
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
    }
}
