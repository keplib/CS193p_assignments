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
        
        cards.shuffle()
    }
    
    struct Card: Identifiable, Equatable {
        var isFaceUp = false
        let content: CardContent
        var isMatched = false
        var id: String
    }
    
    var indexOfPreviouslySelected: Int?
    
    
    
    mutating func shuffleCards() {
        cards.shuffle()
    }
    
    mutating func chooseCard(_ card: Card) {
        let chosenIndex = cards.firstIndex(of: card)
        
        
        if let chosenIndex {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfPreviouslySelected {
                    cards[chosenIndex].isFaceUp = true
                    
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        indexOfPreviouslySelected = nil
                    } else {
                        indexOfPreviouslySelected = nil
                    }
                    
                } else {
                    indexOfPreviouslySelected = chosenIndex
                    for index in cards.indices {
                        if index == indexOfPreviouslySelected {
                            cards[index].isFaceUp = true
                        } else {
                            cards[index].isFaceUp = false
                        }
                    }
                }
            }
        }
        
    }
}
