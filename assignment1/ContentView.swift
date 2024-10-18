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
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0)], spacing: 0) {
                    ForEach(vm.cards) { card in
                        CardView(themeColor: vm.themeColor , card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(4)
                            .animation(.default, value: vm.cards)
                            .onTapGesture {
                                vm.clickCard(card)
                            }
                    }
                }
                
                Button("Start new game") {
                    vm.resetGame()
                }
                
            }
            .padding(.horizontal)
        }
    }
}

struct CardView: View {
    
    var themeColor: Color
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: .init(lineWidth: 2) )
                Text(card.content)
                    .font(.largeTitle)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: 10)
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .foregroundColor(themeColor)
        .opacity(card.isFaceUp || !card.isMatched ? 1: 0)
    }
}

#Preview {
    ContentView(vm: MemoryGameVM())
}
