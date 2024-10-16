//
//  MemoryGameVM.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation
import SwiftUI

class MemoryGameVM: ObservableObject {
    
    private static var emojis = ["👻","🎃","🦇","💀", "🕸️", "🕷️", "👹", "🧙🏽", "😱", "🙀", "🍭", "⚰️"]
    
    private static var themes: Array<Theme> = [
        Theme(themeName: "Halloween", themeColor: .blue, themeEmojis: ["👻","🎃","🦇","💀", "🕸️", "🕷️", "👹", "🧙🏽", "😱", "🙀", "🍭", "⚰️"]),
        Theme(themeName: "Vehicles", themeColor: .red, themeEmojis: ["🚁", "✈️", "🚕", "🚃", "🚲", "🛵", "⛵️", "🚢", "🚀"]),
        Theme(themeName: "Flags", themeColor: .indigo, themeEmojis: ["🇳🇴", "🇸🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇬🇧", "🇮🇪", "🇨🇦"]),
        Theme(themeName: "Sports", themeColor: .teal, themeEmojis: ["🏄🏾‍♀️", "🏀", "🏈", "⚽️", "🏊🏽‍♂️", "🧗🏽‍♀️"]),
        Theme(themeName: "Food", themeColor: .cyan, themeEmojis: ["🥐", "🍔", "🌮", "🧀", "🍱", "🍫", "🧁", "🍎", "🥑", "🍕", "🍒"]),
        Theme(themeName: "Animals", themeColor: .yellow, themeEmojis: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"])
    ]
    
    @Published private var model: MemoryGame<String>
    private var currentTheme: Theme
    
    init() {
        let randomTheme = MemoryGameVM.themes.randomElement()!
        currentTheme = randomTheme
        model = MemoryGameVM.createMemoryGame(with: currentTheme)
    }
    
    private static func createMemoryGame (with theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 13) { pairIndex in
            
            if theme.themeEmojis.indices.contains(pairIndex) {
                theme.themeEmojis[pairIndex]
            } else {
                "⁉️"
            }
        }
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
        let randomTheme = MemoryGameVM.themes.randomElement()!
        currentTheme = randomTheme
        model = MemoryGameVM.createMemoryGame(with: randomTheme)
    }
}

