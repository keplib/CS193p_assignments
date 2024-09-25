//
//  MemoryGameModel.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation

struct MemoryGame<CardContent> {
    
    private(set) var cards: Array<Card>
    
    init (cardContentFactory: () -> CardContent) {
        cards = []
        let content = cardContentFactory()
        cards.append(Card(content: content, id: "1"))

    }
    
    struct Card {
        var isFaceUp = false
        let content: CardContent
        
        var id: String
    }
}
