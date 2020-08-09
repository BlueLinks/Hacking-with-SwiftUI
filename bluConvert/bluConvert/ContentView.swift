//
//  ContentView.swift
//  bluConvert
//
//  Created by Scott Brown on 16/04/2020.
//  Copyright © 2020 Scott Brown. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var unitSelection = 1
    
    static let volumeUnits = [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
    
    static let areaUnits = [UnitArea.squareMeters, UnitArea.squareKilometers, UnitArea.squareInches, UnitArea.squareFeet, UnitArea.squareMiles]
    
    static let lengthUnits = [UnitLength.millimeters, UnitLength.centimeters, UnitLength.meters,
                              UnitLength.inches, UnitLength.feet]
    
    let unitNames = ["Volume", "Area", "Length"]
    let unitList = [volumeUnits, areaUnits, lengthUnits] as [Any]
    
    var units : Array<Dimension>{ return unitList[unitSelection] as! Array<Dimension>}
    
    
    var initalVolume : Measurement<Dimension>{ return Measurement(value: Double(inputValue) ?? 0, unit: units[inputUnit])}
    
    var computedVolume : Measurement<Dimension>{ return initalVolume.converted(to: units[outputUnit])}
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Units to convert")){
                    // Determine which units the user would like converted
                    Picker("Units of measurement to convert", selection: $unitSelection){
                        ForEach(0 ..< unitNames.count){
                            Text(self.unitNames[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section{
                    // Get initial volume
                    TextField("Inital Value", text: $inputValue)
                }.keyboardType(UIKeyboardType.decimalPad)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                )
                
                Section(header: Text("Convert from?")){
                    // Get units to convert from
                    Picker("Convert from selection", selection: $inputUnit){
                        ForEach(0 ..< units.count){
                            Text(self.units[$0].symbol)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert to?")){
                    // Get units to convert to
                    Picker("Convert to selection", selection: $outputUnit){
                        ForEach(0 ..< units.count){
                            Text(self.units[$0].symbol)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("\(initalVolume.description) converted to \(units[outputUnit].symbol) is")){
                    Text("\(computedVolume.description)")
                }
            }.navigationBarTitle("bluConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
