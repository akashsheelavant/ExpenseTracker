//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Akash Sheelavant on 11/22/24.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    var currencyCode: String
    
    init(name: String, type: String, amount: Double, currencyCode: String) {
        self.name = name
        self.type = type
        self.amount = amount
        self.currencyCode = currencyCode
    }
}
