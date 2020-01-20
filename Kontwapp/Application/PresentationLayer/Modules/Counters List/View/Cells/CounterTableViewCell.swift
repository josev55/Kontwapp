//
//  CounterTableViewCell.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

class CounterTableViewCell: UITableViewCell {
    typealias CounterValueUpdated = (_ didIncrement: Bool) -> Void
    @IBOutlet weak var counterTitle: UILabel!
    @IBOutlet weak var counterValueLabel: UILabel!
    @IBOutlet weak var counterStepper: UIStepper!
    var previousValue: Int = 0
    var valueUpdated: CounterValueUpdated?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCell(counter: CounterViewModel) {
        counterTitle.text = counter.title
        counterValueLabel.text = counter.currentValue.description
        counterStepper.value = Double(counter.currentValue)
        previousValue = counter.currentValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func counterValueChanged(_ sender: UIStepper) {
        let newValue = Int(sender.value)
        counterValueLabel.text = newValue.description
        valueUpdated?(newValue > previousValue)
        previousValue = newValue
    }
}
