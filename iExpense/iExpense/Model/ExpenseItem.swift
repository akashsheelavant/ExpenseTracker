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
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currencyCode: String
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double, currencyCode: String) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.currencyCode = currencyCode
    }
}
