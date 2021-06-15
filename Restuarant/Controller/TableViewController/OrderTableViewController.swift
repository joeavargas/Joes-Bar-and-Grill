//
//  OrderTableViewController.swift
//  Restuarant
//
//  Created by Joe Vargas on 6/13/21.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observes changes to the order property and will reload the tableview when it observes a modification
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdatedNotification, object: nil)
    }
    
    // MARK: - Functions
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuController.shared.order.menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        
        return cell
    }

}
