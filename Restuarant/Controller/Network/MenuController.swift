//
//  MenuController.swift
//  Restuarant
//
//  Created by Joe Vargas on 6/13/21.
//

import Foundation

class MenuController {
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    
    // MARK: - Request for /categories
    func fetchCategories(completion: @escaping ([String]?) -> Void){
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: categoryURL) { data, response, error in
            if let data = data,
               let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
               let categories = jsonDictionary["categories"] as? [String]{
                completion(categories)
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    // MARK: - Request for /menu
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void){
        let initialManuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialManuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data){
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // MARK: - Post for /order
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void){
        let orderURL = baseURL.appendingPathComponent("order")
        
        // modify the request from GET to POST then tell the server what kind of data will be sent
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // store the array of menu IDs in JSON under the key "menuIds".
        // create a dictionary of type [String:[Int]], a type that can be converted to or from JSON by an instance of JSONEncoder()
        let data: [String:[Int]] = ["menuIds":menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        // Store the POST data within the body of the request.
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data){
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
