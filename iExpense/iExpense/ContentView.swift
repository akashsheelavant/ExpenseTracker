//
//  ContentView.swift
//  iExpense
//
//  Created by Akash Sheelavant on 12/18/23.
//

import SwiftUI
import Observation

struct ExpenseItem: Identifiable, Codable  {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currencyCode: String
}

@Observable
class Expenses {
    var personalExpenseItems = [ExpenseItem]()
    var businessExpenseItems = [ExpenseItem]()
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            initializeItems()
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.value(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems as! Data) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    private func initializeItems() {
        self.personalExpenseItems = items.filter({ $0.type == "Personal" })
        self.businessExpenseItems = items.filter({ $0.type == "Business" })
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                if(!expenses.personalExpenseItems.isEmpty) {
                    Section("Personal") {
                        ForEach(expenses.personalExpenseItems) { item in
                            HStack {
                                VStack(alignment: .leading, content: {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                })
                                Spacer()
                                Text(item.amount, format:.currency(code: item.currencyCode))
                                    .fontWeight(fontWeight(amount: item.amount))
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                
                if(!expenses.businessExpenseItems.isEmpty) {
                    Section("Business") {
                        ForEach(expenses.businessExpenseItems) { item in
                            HStack {
                                VStack(alignment: .leading, content: {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                })
                                Spacer()
                                Text(item.amount, format:.currency(code: item.currencyCode))
                                    .fontWeight(fontWeight(amount: item.amount))
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
            })
            .navigationTitle("iExpense")
        }
    }
    
    private func fontWeight(amount: Double) -> Font.Weight {
        if(amount < 10) {
            return .regular
        } else if(amount >= 10 && amount < 100) {
            return .medium
        }
        return .semibold
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
