//
//  AddView.swift
//  iExpense
//
//  Created by Akash Sheelavant on 12/30/23.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currencyCode = "USD"
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    let types = ["Business", "Personal"]
    let currencyCodes = ["USD", "EUR", "GBP", "INR"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack {
                    TextField("Amount", value: $amount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                    Picker("", selection: $currencyCode) {
                        ForEach(currencyCodes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
            }
            .navigationTitle("Add new expense item")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currencyCode: currencyCode)
                    modelContext.insert(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView()
}
