//
//  EmojiMemoryView.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/24/20.
//

import SwiftUI

struct EmojiMemoryView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Group() {
            Text(viewModel.themeName)
            Text(String(viewModel.score))
            Grid (items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(5)
            }
            Button("New Game") {
                withAnimation(.easeInOut) {
                    viewModel.newGame()}
            }
        }
        .padding()
        .foregroundColor(viewModel.color)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack() {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(60), clockwise: true)
                        .padding().opacity(0.4)
                    Text(card.content).rotationEffect(Angle.degrees(card.isMatched ? 360 : 0)).animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                    }
                .font(Font.system(size: fontSize(size: geometry.size)))
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    }
    
    // MARKS: - Drawing constants

    private func fontSize (size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryView(viewModel: EmojiMemoryGame())
    }
}
