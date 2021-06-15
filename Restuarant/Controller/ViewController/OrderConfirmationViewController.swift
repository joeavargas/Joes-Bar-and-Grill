//
//  OrderConfirmationViewController.swift
//  Restuarant
//
//  Created by Joe Vargas on 6/15/21.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    // MARK: - Properties
    var minutes: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - Functions
    func updateUI() {
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes"
    }

}
