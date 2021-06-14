//
//  CategoryTableViewController.swift
//  Restuarant
//
//  Created by Joe Vargas on 6/13/21.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    let menuController = MenuController()
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        menuController.fetchCategories { categories in
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
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath){
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
