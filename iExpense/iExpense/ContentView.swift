//
//  ContentView.swift
//  iExpense
//
//  Created by Akash Sheelavant on 12/18/23.
//

import SwiftUI
import Observation

@Observable class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ContentView: View {
    
    @State private var user = User()
    
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            //show the sheet
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, content: {
            SecondView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
