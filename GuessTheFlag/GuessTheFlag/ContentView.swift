//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Scott Brown on 19/04/2020.
//  Copyright © 2020 Scott Brown. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countires = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK","US"].shuffled()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore = 0
    
    @State private var showingReset = false
    
    // Extension
    struct FlagCapsule: View {
        var flagName: String
        
        var body: some View{
            Image(flagName).renderingMode(.original)
            .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
        }
    }
    
     
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(countires[correctAnswer]).foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagCapsule(flagName: self.countires[number])
                    }
                }
                
                
                Text("Score: \(userScore)").foregroundColor(.white)
                    .font(.subheadline).fontWeight(.medium)
                
                Spacer()
                
                Button(action: {
                    self.userScore = 0
                }) {
                        Text("Reset Score").foregroundColor(.white)
                        Image(systemName: "arrow.uturn.left.circle").foregroundColor(.white)
                    
                    }.padding().background(RoundedRectangle(cornerRadius: 15)
                .opacity(0.2))
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"),
                  dismissButton:
            .default(Text("Continue")) {
                    self.askQuestion()
            })
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            self.userScore+=1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong! That’s the flag of \(self.countires[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countires.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
