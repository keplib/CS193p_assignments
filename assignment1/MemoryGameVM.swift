//
//  MemoryGameVM.swift
//  assignment1
//
//  Created by Balázs Képli on 25/9/24.
//

import Foundation
import SwiftUI

class MemoryGameVM: ObservableObject {
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame {
            return "🏀"
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
}
