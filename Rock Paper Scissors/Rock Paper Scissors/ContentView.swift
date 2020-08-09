//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Scott Brown on 26/04/2020.
//  Copyright © 2020 Scott Brown. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var userChoice = 0
    @State private var appChoice = Int.random(in:0 ... 2)
    @State private var toWin = Bool.random()
    @State private var playerScore = 0
    @State private var roundLog = ""
    @State private var showingReset = false
    
    let moveEmoji = ["✊","✋","✌️"]
    
    var aimText : String {
        return toWin ? "win" : "lose"
    }
    

    
    var body: some View {
        VStack(spacing: 10){
            Spacer().frame(minHeight: 10, maxHeight: 10)
            Text("Rock Paper Scissors").font(.largeTitle)
            
            // Shown outcome of last round
            Text(roundLog)
            
            Spacer()
            
            VStack{
            Text("Players Score: \(playerScore)")
            
            HStack(){
                Text("CPU choses: ").font(.largeTitle)
                Text("\(moveEmoji[appChoice])").font(.largeTitle)
                .padding()
                .background(Color.gray)
                .clipShape(Capsule())
            }
            Text("You must \(aimText)")
            }
            Spacer()
            Spacer()
            
            Text("Your choices")
            HStack(spacing: 30){
                ForEach(0 ..< 3){ number in
                    // Button for each move
                    Button(action: {
                        self.moveTapped(moveNum: number)
                    }) {
                        Text("\(self.moveEmoji[number])").font(.largeTitle)
                        .padding()
                            .background(Color.blue)
                            .clipShape(Capsule())
                        }
                    }
                }
            Spacer()
        }.alert(isPresented: $showingReset){
            // Alert for when the player wins the game
        Alert(title: Text("You win!"), message: Text("Congratualtions, you have won! 🎉"),
              dismissButton:
        .default(Text("Reset")) {
            self.playerScore = 0
            self.roundLog = ""
                self.nextTurn()
        })
        }
        
    }
    
    func moveTapped(moveNum: Int){
        // Called when player makes a move
        userChoice = moveNum
        switch toWin {
        case true:
            // Player must win
            if (userChoice == 0){
                // adjust choice to wrap around
                userChoice = 3
            }
            if (userChoice - 1 == appChoice){
                roundLog = "Correct!"
                playerScore+=1
            } else {
                roundLog = "Wrong!"
            }
            nextTurn()
        case false:
            // Player must Lose
            if (userChoice == 2){
                // adjust choice to wrap around
                userChoice = -1
            }
            if (userChoice + 1 == appChoice){
                roundLog = "Correct!"
                playerScore+=1
            } else {
                roundLog = "Wrong!"
            }
            nextTurn()
        }
    }
    
    func nextTurn() {
        // set up next turn
        if (playerScore == 10){
            // check if the player has won the game or not
            showingReset.toggle()
        }
        toWin = Bool.random()
        appChoice = Int.random(in:0 ... 2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
