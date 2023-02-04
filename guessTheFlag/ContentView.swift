//
//  ContentView.swift
//  guessTheFlag
//
//  Created by Abhimanyu Personal on 02/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isDialogShowing = false
    @State private var guessedWrong = false
    @State private var message = ""
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            ZStack{
                RadialGradient(stops: [
                    .init(color: .red, location: 0.3),
                    .init(color: .blue, location: 0.3)
                ],center: .top,startRadius: 200,endRadius: 700)
              .ignoresSafeArea()
                VStack(spacing: 30){
                    VStack {
                        Text("Can you guess the flag for").font(.subheadline.weight(.heavy)).foregroundStyle(.secondary)
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                            .foregroundColor(.primary)
                    }
                    ForEach (0..<3){
                        number in Button{
                            showDialog(_selectedIndex: number)
            
                        }label: {
                            Image(countries[number])
                                                            .renderingMode(.original)
                                                            .clipShape(Capsule())
                                                            .shadow(radius: 5)
                        }
                   
                    }
                    Text("Your score is \(score)")
                }.frame(maxWidth: .infinity).padding(.vertical,20).background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 20)).padding(.all,20)
            }.navigationTitle("Guess The Flag").foregroundColor(.white)
        
        } .alert(message, isPresented: $isDialogShowing) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }

    }
    func showDialog( _selectedIndex: Int) {
        if _selectedIndex == correctAnswer{
            message = "Correct!"
            score += 1
        }else{
            message = "Wrong!"
            guessedWrong = true
        }
        isDialogShowing = true

    }
    func askQuestion() {
        if(guessedWrong){
            score = 0
            guessedWrong = false
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
