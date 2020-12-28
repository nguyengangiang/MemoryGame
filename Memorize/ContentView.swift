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
        Grid (items: viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
    .padding()
    .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    Text(card.content)
                    }
                else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            .font(Font.system(size: fontSize(size: geometry.size)))
        }
        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
    }
    
    // MARKS: - Drawing constants
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 3
    func fontSize (size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
