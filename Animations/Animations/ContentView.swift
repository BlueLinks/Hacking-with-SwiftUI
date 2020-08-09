//
//  ContentView.swift
//  Animations
//
//  Created by Scott Brown on 09/08/2020.
//  Copyright © 2020 Scott Brown. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        
        Button("Tap me"){
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
