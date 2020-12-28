//
//  ContentView.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/24/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
    HStack {
        ForEach(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
        }
    }
    .padding()
    .foregroundColor(Color.orange)
    .font(viewModel.numberOfPairsOfCards < 5 ? .largeTitle : .title)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack() {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                Text(card.content)
                }
            else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
