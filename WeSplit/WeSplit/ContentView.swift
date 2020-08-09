//
//  ContentView.swift
//  WeSplit
//
//  Created by Scott Brown on 09/04/2020.
//

import SwiftUI



struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeopleInput = ""
    @State private var tipPercentage = 2
    
    //ExtensionChallenge
    var useRedText: Bool {
        if tipPercentage == 3 {
            return true
        }
        return false
    }
     
    let tipPercentages = [10, 15, 20, 0]
    
    var peopleCount: Int { return Int(numberOfPeopleInput) ?? 2}
    
    var orderAmount: Double { return Double(checkAmount) ?? 0}
    
    var tipAmount: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipTotal = orderAmount / 100 * tipSelection
        return tipTotal
    }
    
    var grandTotal: Double{ return orderAmount + tipAmount }
    
    var totalPerPerson: Double { return grandTotal  / Double(peopleCount)}
    
    var body: some View{
        NavigationView{
            Form {
                Section(header: Text("Amount to split?")) {
                    HStack{
                        Text("£")
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    )
                    
                    
                    HStack{
                    TextField("Number of people", text: $numberOfPeopleInput)
                    .keyboardType(.decimalPad)
                    Text("People")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    )
                }
                
                Section(header: Text("How much tip would you like to leave?")){
                    Picker("Tip percentage", selection:
                    $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Bill comes to")){
                    Text("£\(Double(checkAmount) ?? 0, specifier: "%.2f")")
                }
                
                Section(header: Text("\(Double(tipPercentages[tipPercentage]), specifier: "%.f")% tip will be an extra")
                .foregroundColor(useRedText ? .red : .none)){
                    Text("£\(tipAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Grand Total is")){
                    Text("£\(grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Therefore between \(peopleCount) people the total per person is")){
                    Text("£\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
