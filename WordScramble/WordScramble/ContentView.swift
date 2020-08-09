//
//  ContentView.swift
//  WordScramble
//
//  Created by Scott Brown on 29/07/2020.
//  Copyright © 2020 Scott Brown. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String()]
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        
        NavigationView{
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord).autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                List(usedWords, id: \.self) {
                    if $0 != "" {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                    }
                }
                Text("Score : \(score)")
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        .navigationBarItems(trailing: Button("Restart") {
            self.startGame()
        })
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognised", message: "You can't just make them up you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        guard isNotSmall(word: answer) else {
            wordError(title: "Word is too small!", message: "Your word must be 3 or more characters long!")
            return
        }
        
        guard isAnswer(word: answer) else {
            wordError(title: "Be more original!", message: "You can't just use the same word!")
            return
        }
        
        score += answer.count
        usedWords.insert(answer, at: 0)
        newWord = ""
        
    }
    
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                usedWords = [String()]
                score = 0
                rootWord = allWords.randomElement() ?? "silkworm"

                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isAnswer(word : String) -> Bool {
        if word == rootWord{
            return false
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isNotSmall(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        return true
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
