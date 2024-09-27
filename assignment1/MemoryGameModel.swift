//
//  MemoryGameModel.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var cards: Array<Card> = []
    
    init(numberOfPairsOfCards: Int, getContent: (Int) -> CardContent) {
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = getContent(pairIndex)
            cards.append(Card(content: content , id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content , id: "\(pairIndex + 1)b" ))
        }
    }
    
    struct Card: Identifiable, Equatable {
        var isFaceUp = true
        let content: CardContent
        
        var id: String
    }
    
    mutating func shuffleCards() {
        cards.shuffle()
    }
}
