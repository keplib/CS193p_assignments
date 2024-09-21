//
//  ContentView.swift
//  assignment1
//
//  Created by Balázs Képli on 16/9/24.
//

import SwiftUI





struct ContentView: View {
    
    @State var chosenTheme: Array<String> = []
    @State var cardCount: Int
    
    let vehicles = ["🚁", "✈️", "🚕", "🚃", "🚲", "🛵", "⛵️", "🚢", "🚀"]
    let sports = ["🏄🏾‍♀️", "🏀", "🏈", "⚽️", "🏊🏽‍♂️", "🧗🏽‍♀️"]
    let food = ["🥐", "🍔", "🌮", "🧀", "🍱", "🍫", "🧁", "🍎", "🥑", "🍕", "🍒"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView {
                if chosenTheme.count > 0 {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0)], spacing: 0) {
                        ForEach(0..<cardCount, id: \.self) { index in
                            Group {
                                CardView(isFaceUp: true, content: chosenTheme[index])
                            }
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(4)
                        }
                    }
                } else {
                    Text("Please choose a theme below")
                }
            }
            .padding(.horizontal)
            
            HStack {
                cardRemover
                
                vehiclesTheme
                foodTheme
                sportsTheme
                
                cardAdder
                
            }
        }
    }
    
    
    func createThemeButton (for themeName: String, with iconName: String, emojis data: Array<String>) -> some View {
        VStack {
            Image(systemName: iconName)
            Text(themeName)
        }
        .foregroundColor(.blue)
        .padding(.horizontal)
        .onTapGesture {
            chosenTheme = (data + data).shuffled()
            cardCount = chosenTheme.count
        }
        
    }
    
    var sportsTheme: some View {
        createThemeButton(for: "Sports", with: "figure.outdoor.cycle", emojis: sports)
    }
    
    var vehiclesTheme: some View {
        createThemeButton(for: "Vehicles", with: "car", emojis: vehicles)
    }
    
    var foodTheme: some View {
        createThemeButton(for: "Food", with: "fork.knife", emojis: food)
    }
    

    
    func createAddButton (by offset: Int, symbol: String ) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > chosenTheme.count)
    }
    
    var cardAdder: some View {
        createAddButton(by: 1, symbol: "plus.circle")
    }
    
    var cardRemover: some View {
        createAddButton(by: -1, symbol: "minus.circle")
    }
}


struct CardView: View {
    
    @State var isFaceUp: Bool
    
    let content: String
    
    var body: some View {
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: .init(lineWidth: 2) )
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: 10)
                .opacity(isFaceUp ? 0 : 1)
        }
        .foregroundColor(.orange)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView(chosenTheme: [], cardCount: 3)
}
