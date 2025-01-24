//
//  ContentView.swift
//  iExpense
//
//  Created by Akash Sheelavant on 12/18/23.
//

import SwiftUI
import Observation
import SwiftData

struct ContentView: View {
    
    @State private var showingAddExpense = false
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    private let filterOptions = ["All", "Personal", "Business"]
    @State private var selectedFilterIndex = 0
    
    var body: some View {
        NavigationStack {
            ExpenseItemView(expenseType: filterOptions[selectedFilterIndex], sortOrder: sortOrder)
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                    
                    Button(filterOptions[selectedFilterIndex] + " Expenses") {
                        selectedFilterIndex += 1
                        selectedFilterIndex %= filterOptions.count
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
                    
                }
                .sheet(isPresented: $showingAddExpense, content: {
                    AddView()
                })
                .navigationTitle("iExpense")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
