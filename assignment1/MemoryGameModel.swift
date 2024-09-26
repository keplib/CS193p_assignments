//
//  MemoryGameModel.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation
import SwiftUI
//struct MemoryGame<CardContent> {
//    
//    private(set) var cards: Array<Card>
//    
//    init (cardContentFactory: () -> CardContent) {
//        cards = []
//        let content = cardContentFactory()
//        cards.append(Card(content: content, id: "1"))
//
//    }
//    
//    struct Card {
//        var isFaceUp = false
//        let content: CardContent
//        
//        var id: String
//    }
//}

struct MemoryGame {
    
    var cards: Array<Card> = []
    
    init(numberOfCards: Int, getContent: (Int) -> String) {
        for index in 0..<numberOfCards {
            let content = getContent(index)
            let id = String(index)
            cards.append(Card(content: content , id: id ))
        }
    }
    
    struct Card: Hashable {
        var isFaceUp = true
        let content: String
        
        var id: String
    }
}
