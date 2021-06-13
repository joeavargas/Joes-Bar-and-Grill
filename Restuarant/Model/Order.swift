//
//  Order.swift
//  Restuarant
//
//  Created by Joe Vargas on 6/13/21.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []){
        self.menuItems = menuItems
    }
}
