//
//  MemoryGameVM.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation
import SwiftUI

class MemoryGameVM: ObservableObject {
    
    init() {
        currentTheme = themes.randomElement()!
        model = MemoryGameVM.createMemoryGame(with: currentTheme)
    }
    
    @Published private var model: MemoryGame<String>
    private var currentTheme: Theme<String>
    
    
    private static func createMemoryGame (with theme: Theme<String>) -> MemoryGame<String> {
        let setOfThemeEmojis = theme.setOfThemeEmojis
        
        let passCard = {(index: Int) -> String in
            if setOfThemeEmojis.indices.contains(index) {
                setOfThemeEmojis[index]
            } else {
                "⁉️"
            }
        }
        return MemoryGame(numberOfPairsOfCards: 13, getContent: passCard)
    }
    
    func resetGame()  {
        currentTheme = themes.randomElement()!
        model = MemoryGameVM.createMemoryGame(with: currentTheme)
    }
    
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    var themeColor: Color { currentTheme.themeColor}
    
    func shuffleCards() {
        model.shuffleCards()
    }
    
    func clickCard(_ card:MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}

let themes: Array<Theme<String>> = [
    Theme(themeName: "Halloween", setOfThemeEmojis: ["👻","🎃","🦇","💀", "🕸️", "🕷️", "👹", "🧙🏽", "😱", "🙀", "🍭", "⚰️"], themeColor: .blue),
    Theme(themeName: "Vehicles", setOfThemeEmojis: ["🚁", "✈️", "🚕", "🚃", "🚲", "🛵", "⛵️", "🚢", "🚀"], themeColor: .yellow),
    Theme(themeName: "Food", setOfThemeEmojis: ["🥐", "🍔", "🌮", "🧀", "🍱", "🍫", "🧁", "🍎", "🥑", "🍕", "🍒"], themeColor: .green),
    Theme(themeName: "Sports", setOfThemeEmojis: ["🏄🏾‍♀️", "🏀", "🏈", "⚽️", "🏊🏽‍♂️", "🧗🏽‍♀️"], themeColor: .orange),
    Theme(themeName: "Flags", setOfThemeEmojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"], themeColor: .teal),
    Theme(themeName: "Animals", setOfThemeEmojis: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"], themeColor: .red)
]
