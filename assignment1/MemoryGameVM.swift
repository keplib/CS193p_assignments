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
        let setOfThemeEmojis = theme.setOfThemeEmojis.shuffled()
        
        let passCard = {(index: Int) -> String in
            setOfThemeEmojis[index]
        }
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs, getContent: passCard)
    }
    
    func resetGame()  {
        currentTheme = themes.randomElement()!
        model = MemoryGameVM.createMemoryGame(with: currentTheme)
    }
    
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    var score: Int { model.score }
    
    var themeColor: Color {
        switch currentTheme.themeColor {
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "green":
            return .green
        case "orange":
            return .orange
        case "teal":
            return .teal
        case "red":
            return .red
        default:
            return .primary
        }
    }
    
    //var themeColor: Color { currentTheme.themeColor}
    
    func shuffleCards() {
        model.shuffleCards()
    }
    
    func clickCard(_ card:MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}

let themes: Array<Theme<String>> = [
    Theme(themeName: "Halloween", setOfThemeEmojis: ["👻","🎃","🦇","💀", "🕸️", "🕷️", "👹", "🧙🏽", "😱", "🙀", "🍭", "⚰️"], themeColor: "blue", numberOfPairs: 10),
    Theme(themeName: "Vehicles", setOfThemeEmojis: ["🚁", "✈️", "🚕", "🚃", "🚲", "🛵", "⛵️", "🚢", "🚀"], themeColor: "yellow", numberOfPairs: 8),
    Theme(themeName: "Food", setOfThemeEmojis: ["🥐", "🍔", "🌮", "🧀", "🍱", "🍫", "🧁", "🍎", "🥑", "🍕", "🍒"], themeColor: "green", numberOfPairs: 7),
    Theme(themeName: "Sports", setOfThemeEmojis: ["🏄🏾‍♀️", "🏀", "🏈", "⚽️", "🏊🏽‍♂️", "🧗🏽‍♀️"], themeColor: "orange", numberOfPairs: 5),
    Theme(themeName: "Flags", setOfThemeEmojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"], themeColor: "teal", numberOfPairs: 8),
    Theme(themeName: "Animals", setOfThemeEmojis: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"], themeColor: "red", numberOfPairs: 6)
]
