//
//  MemoryGameVM.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation
import SwiftUI

//class MemoryGameVM: ObservableObject {
//    
//    private static func createMemoryGame() -> MemoryGame<String> {
//        return MemoryGame {
//            return "🏀"
//        }
//    }
//    
//    @Published private var model = createMemoryGame()
//    
//    var cards: Array<MemoryGame<String>.Card> {
//        return model.cards
//    }
//    
//    
//}

class MemoryGameVM: ObservableObject {
    
    private static let emojis = ["👻","🎃","🦇","💀", "🕸️", "🕷️", "👹", "🧙🏽", "😱", "🙀", "🍭", "⚰️"]
    
    private let themes: Array<Theme> = [
        Theme(themeName: "Halloween", themeColor: .blue, themeEmojis: ["👻","🎃","🦇","💀", "🕸️", "🕷️", "👹", "🧙🏽", "😱", "🙀", "🍭", "⚰️"]),
        Theme(themeName: "Vehicles", themeColor: .red, themeEmojis: ["🚁", "✈️", "🚕", "🚃", "🚲", "🛵", "⛵️", "🚢", "🚀"]),
        Theme(themeName: "Flags", themeColor: .indigo, themeEmojis: ["🇳🇴", "🇸🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇬🇧", "🇮🇪", "🇨🇦"]),
        Theme(themeName: "Sports", themeColor: .teal, themeEmojis: ["🏄🏾‍♀️", "🏀", "🏈", "⚽️", "🏊🏽‍♂️", "🧗🏽‍♀️"]),
        Theme(themeName: "Food", themeColor: .cyan, themeEmojis: ["🥐", "🍔", "🌮", "🧀", "🍱", "🍫", "🧁", "🍎", "🥑", "🍕", "🍒"]),
        Theme(themeName: "Animals", themeColor: .yellow, themeEmojis: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"])
    ]
    
    @Published private var model: MemoryGame<String>
    @Published private var currentTheme: Theme
   
    
    init() {
        let theme = themes.randomElement()!
        model = MemoryGameVM.createMemoryGame()
        currentTheme = theme
    }
    
    
    
    private static func passCardContent(index: Int) -> String {
        if emojis.indices.contains(index) {
            return emojis[index]
        } else {
            return "⁉️"
        }
        
    }
    
    private static func createMemoryGame () -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 13, getContent: passCardContent)
    }
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeColor: Color {
        return currentTheme.themeColor
    }
    
    var themeName: String {
        return currentTheme.themeName
    }
    
    func shuffleCards() {
        model.shuffleCards()
    }
    
    func clickCard(_ card:MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
    
    func createNewGame()  {
         model = MemoryGameVM.createMemoryGame()
    }
}

