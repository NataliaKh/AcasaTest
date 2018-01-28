//
//  BillMapper.swift
//  AcasaTest
//
//  Created by Natuka on 27/01/2018.
//  Copyright © 2018 Natalia. All rights reserved.
//

import Foundation

class BillMapper {
    
   class func map(json: [String: Any]) -> Bill? {
        
        guard let id = json["id"] as? String,
              let title = json["title"] as? String,
              let createdAt = json["created_at"] as? String,
              let disabled = json["disabled"] as? Bool,
              let upcoming = json["upcoming"] as? Bool,
              let recurFreqDays = json["recur_freq_days"] as? Int,
              let recurFreqMonths = json["recur_freq_months"] as? Int,
              let recurDayNum = json["recur_day_num"] as? Int,
              let amountInPence = json["amount_pence"] as? Int,
              let dueDate = json["due_date"] as? String,
              let houseName = json["house_name"] as? String,
              let payerName = json["payer_name"] as? String,
              let categoryIconURL = json["category_icon"] as? String,
              let userShareAmountInPence = json["user_share_amount_pence"] as? Int else {
                
            return nil
        }
        
        var category: Category?
        if let categoryString = json["category"] as? String {
            category = Category(rawValue: categoryString)
        }
        
        let bill = Bill(id: id, title: title, category: category, createdAt: createdAt, disabled: disabled, upcoming: upcoming, recurFreqDays: recurFreqDays, recurFreqMonths: recurFreqMonths, recurDayNum: recurDayNum, amountInPence: amountInPence, dueDate: dueDate, houseName: houseName, payerName: payerName, categoryIconURL: categoryIconURL, userShareAmountInPence: userShareAmountInPence)
        return bill
    }
}
