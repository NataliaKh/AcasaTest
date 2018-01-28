//
//  BillStore.swift
//  AcasaTest
//
//  Created by Natuka on 27/01/2018.
//  Copyright © 2018 Natalia. All rights reserved.
//

import Foundation

class BillStore {
    
    var bills = [Bill]()
    
    private var jsonURL = "https://api.myjson.com/bins/107b4d"
    private var networkManager: NetworkManager!
    
    init() {
        networkManager = NetworkManager()
    }
    
    func fetchBills(completion:@escaping ([Bill]) -> Void) {
        networkManager.getJSON(with: jsonURL, success: { (json) -> (Void) in
            if let json = json as? [[String: Any]] {
                self.createBills(json: json)
                completion(self.bills)
            }
        }) { (error) -> (Void) in
            print("Error fetching bills - \(error.localizedDescription)")
        }
    }
    
    private func createBills(json: [[String: Any]]) {
        for billDictionary in json {
            if let bill = BillMapper.map(json: billDictionary) {
                bills.append(bill)
            }
        }
    }
}

