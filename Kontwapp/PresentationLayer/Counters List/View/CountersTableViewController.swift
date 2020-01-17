//
//  CountersTableViewController.swift
//  PresentationLayer
//
//  Created by Jose Vildosola on 16-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import UIKit

public class CountersTableViewController: UITableViewController {

    var countersDataSource = [CounterViewModel]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        countersDataSource.append(CounterViewModel(title: "Some Text", currentValue: 0))
        setLayout()
    }
    
    private func setLayout() {
        let addCounterButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCounter))
        addCounterButton.tintColor = Color.primary
        self.navigationItem.rightBarButtonItem = addCounterButton
    }
    
    @objc private func addCounter() {
    }

    // MARK: - Table view data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            countersDataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
