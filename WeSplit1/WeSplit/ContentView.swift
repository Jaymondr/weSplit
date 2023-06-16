//
//  ContentView.swift
//  WeSplit
//
//  Created by Jaymond Richardson on 6/13/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25 ,0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue

        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Amount")
                        .padding(.leading, -20)
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Grand Total")
                        .padding(.leading, -20)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount Per Person")
                        .padding(.leading, -20)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
