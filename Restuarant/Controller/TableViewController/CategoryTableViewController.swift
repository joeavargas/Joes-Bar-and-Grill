//
//  CategoryTableViewController.swift
//  Restuarant
//
//  Created by Joe Vargas on 6/13/21.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        MenuController.shared.fetchCategories { categories in
            if let categories = categories{
                DispatchQueue.main.async {
                    self.updateUI(with: categories)
                }
            }
        }
    }
    
    // MARK: - Functions
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath){
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        
        configure(cell, forItemAt: indexPath)

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
    }
    

}
