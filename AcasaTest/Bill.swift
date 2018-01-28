//
//  Bill.swift
//  AcasaTest
//
//  Created by Natuka on 27/01/2018.
//  Copyright © 2018 Natalia. All rights reserved.
//

import Foundation

enum Category: String {
    case Utilities
    case HomeSupplies = "Home Supplies"
    case Groceries
    case InternetTV = "Internet/TV"
    case Rent
    case CouncilTax = "Council Tax"
}

struct Bill {
    var id: String
    var title: String
    var category: Category?
    var createdAt: String
    var disabled: Bool
    var upcoming: Bool
    var recurFreqDays: Int
    var recurFreqMonths: Int
    var recurDayNum: Int
    var amountInPence: Int
    var dueDate: String
    var houseName: String
    var payerName: String
    var categoryIconURL: String
    var userShareAmountInPence: Int
}

