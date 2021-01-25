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
                CardView(card: card).onTapGesture { withAnimation(.linear(duration: 0.5)) {viewModel.choose(card: card)}
                }
                .padding(5)
            }
        }
        .padding()
        .foregroundColor(viewModel.color)
    }
}

struct CardView: View {
    @State var animatedBonusRemaining: Double = 0
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {animatedBonusRemaining = 0}
    }
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack() {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockwise: true).onAppear{
                                    self.startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                        }
                    }.opacity(0.4).padding()

                    Text(card.content).rotationEffect(Angle.degrees(card.isMatched ? 360 : 0)).animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                    }
                .font(Font.system(size: fontSize(size: geometry.size)))
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
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
        EmojiMemoryView(viewModel: EmojiMemoryGame(name: "Memory Game"))
    }
}
