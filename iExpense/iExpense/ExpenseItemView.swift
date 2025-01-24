//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Akash Sheelavant on 12/5/24.
//

import SwiftData
import SwiftUI

struct ExpenseItemView: View {
    @Query var items: [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    
    init(expenseType: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        _items = Query(filter: #Predicate<ExpenseItem> { item in
            return expenseType == "All" ? true : item.type == expenseType
        }, sort: sortOrder)
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
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
    
    private func fontWeight(amount: Double) -> Font.Weight {
        if(amount < 10) {
            return .regular
        } else if(amount >= 10 && amount < 100) {
            return .medium
        }
        return .semibold
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(items[offset])
        }
    }
}

#Preview {
    ExpenseItemView(expenseType: "Personal", sortOrder: [SortDescriptor(\ExpenseItem.name)])
}
