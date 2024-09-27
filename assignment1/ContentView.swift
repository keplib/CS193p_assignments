//
//  ContentView.swift
//  assignment1
//
//  Created by Balázs Képli on 16/9/24.
//

import SwiftUI


struct ThemeObject {
    var emojis: Array<String>
    var color: Color
}

struct Themes {
    
}


struct ContentView: View {
    
    @State var chosenTheme: Array<String> = []
    @State var cardCount: Int
    @State var themeColor: Color
    
    @ObservedObject var vm: MemoryGameVM
//    
//    let gameThemes: [ThemeObject] = [
//        ThemeObject(emojis: ["🚁", "✈️", "🚕", "🚃", "🚲", "🛵", "⛵️", "🚢", "🚀"], color: Color(.red)),
//        ThemeObject(emojis: ["🏄🏾‍♀️", "🏀", "🏈", "⚽️", "🏊🏽‍♂️", "🧗🏽‍♀️"], color: Color(.blue)),
//        ThemeObject(emojis: ["🥐", "🍔", "🌮", "🧀", "🍱", "🍫", "🧁", "🍎", "🥑", "🍕", "🍒"], color: Color(.orange))
//    ]
        
    
    
    
    let vehicles = ["🚁", "✈️", "🚕", "🚃", "🚲", "🛵", "⛵️", "🚢", "🚀"]
    let sports = ["🏄🏾‍♀️", "🏀", "🏈", "⚽️", "🏊🏽‍♂️", "🧗🏽‍♀️"]
    let food = ["🥐", "🍔", "🌮", "🧀", "🍱", "🍫", "🧁", "🍎", "🥑", "🍕", "🍒"]
    
    let vehiclesColor = Color(.orange)
    let sportsColor = Color(.blue)
    let foodColor = Color(.red)
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView {
                if chosenTheme.count > 0 {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0)], spacing: 0) {
                        ForEach(vm.cards) { card in
                            CardView(isFaceUp: true, themeColor: $themeColor, content: card.content)
                                .aspectRatio(2/3, contentMode: .fit)
                                .padding(4)
                                .animation(.default, value: vm.cards)
                            
                        }
                    }
                } else {
                    Text("Please choose a theme below")
                }
            }
            .padding(.horizontal)
            
            Button(action: {
                vm.shuffleCards()
            }, label: {
                Text("Shuffle cards")
            })
            
            HStack {
                cardRemover
                
                vehiclesTheme
                foodTheme
                sportsTheme
                
                cardAdder
                
            }
        }
    }
    
    
    func createThemeButton (for themeName: String, with iconName: String, emojis data: Array<String>, color: Color) -> some View {
        VStack {
            Image(systemName: iconName)
            Text(themeName)
        }
        .foregroundColor(.blue)
        .padding(.horizontal)
        .onTapGesture {
            chosenTheme = (data + data).shuffled()
            cardCount = chosenTheme.count
            themeColor = color
        }
        
    }
    
    var sportsTheme: some View {
        createThemeButton(for: "Sports", with: "figure.outdoor.cycle", emojis: sports, color: sportsColor)
    }
    
    var vehiclesTheme: some View {
        createThemeButton(for: "Vehicles", with: "car", emojis: vehicles, color: vehiclesColor)
    }
    
    var foodTheme: some View {
        createThemeButton(for: "Food", with: "fork.knife", emojis: food, color: foodColor)
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
    @Binding var themeColor: Color
    
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
        .foregroundColor(themeColor)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView(chosenTheme: [], cardCount: 3, themeColor: .red, vm: MemoryGameVM())
}
