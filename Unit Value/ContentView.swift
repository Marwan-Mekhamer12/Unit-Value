//
//  ContentView.swift
//  Unit Value
//
//  Created by Marwan Mekhamer on 09/04/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inPutValue = "Meter"
    @State private var unitValue = 0.0
    @State private var outPutValue = "KiloMeter"
    @FocusState private var isHiddingKeyboard: Bool
    
    private let units = ["Meter", "KiloMeter", "Feet"]
    
    
    private func ToMeter(_ value: Double, unit: String) -> Double {

        switch unit {
        case "KiloMeter":
            return value * 1000
        case "Feet":
            return value / 3.28084
        default:
            return value
        }
    }
    
    private func FromMeter(_ value: Double, unit: String) -> Double {
        
        switch unit {
        case "KiloMeter":
            return value / 1000
        case "Feet":
            return value * 3.28084
        default:
            return value
        }
    }
    
    var convertValue: Double {
        let meter = ToMeter(unitValue, unit: inPutValue)
        return FromMeter(meter, unit: outPutValue)
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose your unit?") {
                    
                    TextField("Add your value", value: $unitValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isHiddingKeyboard)
                    
                    Picker("input Unit", selection: $inPutValue) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                   
                }
                
                Section("Change to...") {
                    Picker("output Unit", selection: $outPutValue) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section {
                    Text(convertValue, format: .number)
                }
            }
            
            .navigationTitle("Unit Value")
            .toolbar {
                if isHiddingKeyboard {
                    Button("Done") {
                        isHiddingKeyboard = false
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
