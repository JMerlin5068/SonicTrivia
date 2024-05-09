//
//  ContentView.swift
//  SonicTrivia
//
//  Created by Student on 5/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var characters = ["Sonic The Hedgehog", "Tails The Fox", "Knuckles The Echidna", "Shadow The Hedgehog", "Rouge The Bat", "E-123 Omega", "Amy Rose", "Big The Cat"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var combo = 0
    @State private var question = 0
    @State private var title = "Sonic Trivia Game"
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text(title)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        if(question <= 6) {
                            Text("\(characters[correctAnswer]):")
                                .font(.largeTitle.weight(.semibold))
                        } else {
                            Text("Winner!")
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                    }
                    ForEach(0..<3) {
                        number in Button {
                            charTapped(number)
                        } label: {
                            if(question <= 6) {
                                Image(characters[number])
                            } else {
                                Image("win")
                                
                            }
                        }
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text("Score: \(score) Streak: \(combo)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score). Your streak is \(combo).")
        }
    }
    
    func charTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            combo += 1
            question += 1
        } else {
            scoreTitle = "Wrong! \(characters[number])"
            combo = 0
            question += 1
        }
        if(question>=6) {
            scoreTitle = "You win! your score is \(score)"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        if(question <= 6) {
            characters.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            title="Sonic Trivia Game \n You Win!"
            
            
        }
    }
}

    


#Preview {
    ContentView()
}
