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
            Button("New Game") {viewModel.newGame()}
        }
        .padding()
        .foregroundColor(viewModel.color)
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
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(60), clockwise: true)
                        .padding().opacity(0.4)
                    Text(card.content)
                    }
                else {
                    if (!card.isMatched) {
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
            }
            .font(Font.system(size: fontSize(size: geometry.size)))
        }
    }
    
    // MARKS: - Drawing constants
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 3
    private func fontSize (size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryView(viewModel: EmojiMemoryGame())
    }
}
