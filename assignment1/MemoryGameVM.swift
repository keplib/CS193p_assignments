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
    
    private static func passCardContent(index: Int) -> String {
        if emojis.indices.contains(index) {
            return emojis[index]
        } else {
            return "⁉️"
        }
        
    }
    
    @Published private var model = createMemoryGame()
    

    private static func createMemoryGame () -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 13, getContent: passCardContent)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func shuffleCards() {
        model.shuffleCards()
    }
    
    func clickCard(_ card:MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}
