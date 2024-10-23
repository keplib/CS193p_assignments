//
//  ContentView.swift
//  assignment1
//
//  Created by Balázs Képli on 16/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm: MemoryGameVM

    var body: some View {
        VStack {
            
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Your scores: \(vm.score)")
            
        
                cards
                    .animation(.default, value: vm.cards)
            
            
            Button("Start new game") {
                vm.resetGame()
            }
        }
        .padding(.horizontal)
    }
    
    
    var cards: some View {
        GeometryReader { geometry in
            
            let gridItemSize = gridItemWidthThatFits(count: vm.cards.count, size: geometry.size, atAspectRatio: 2/3)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(vm.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            vm.clickCard(card)
                        }
                }
            }
        }
        .foregroundColor(vm.themeColor)
    }
        
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let cardCount = CGFloat(count)
        var columnCount: CGFloat = 1

        while columnCount <= cardCount {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (cardCount / columnCount).rounded(.up)
            
            
            if rowCount * height <= size.height  {
                return width.rounded(.down)
            }
            
            columnCount += 1
        }
        
        let result = min(size.width / cardCount, size.height * aspectRatio).rounded(.down)
        return result
    }
}

struct CardView: View {
        
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 50))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1: 0)
    }
}

#Preview {
    ContentView(vm: MemoryGameVM())
}
