//
//  MemoryGameModel.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> {
    
    var cards: Array<Card> = []
    
    init(numberOfCards: Int, getContent: (Int) -> CardContent) {
        for index in 0..<numberOfCards {
            let content = getContent(index)
            let id = String(index)
            cards.append(Card(content: content , id: id ))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        let content: CardContent
        
        var id: String
    }
}
