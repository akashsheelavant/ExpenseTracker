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
    @Environment(\.modelContext) var modelContext
    
    @Query(filter: #Predicate<ExpenseItem>{ item in
        item.type == "Personal"
    }, sort: \ExpenseItem.name) var personalExpenseItems: [ExpenseItem]
    
    @Query(filter: #Predicate<ExpenseItem>{ item in
        item.type == "Business"
    }, sort: \ExpenseItem.name) var businessExpenseItems: [ExpenseItem]
    
    
    var body: some View {
        NavigationStack {
            List {
                if(!personalExpenseItems.isEmpty) {
                    Section("Personal") {
                        ForEach(personalExpenseItems) { item in
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
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                if(!businessExpenseItems.isEmpty) {
                    Section("Business") {
                        ForEach(businessExpenseItems) { item in
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
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView()
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
    
    func removePersonalItems(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(personalExpenseItems[offset])
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(businessExpenseItems[offset])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
