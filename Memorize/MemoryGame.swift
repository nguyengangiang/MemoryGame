//
//  MemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    mutating func choose(card: Card) {
        print("Card chosen: \(card)")
        cards[index(of: card)].isFaceUp = !cards[index(of: card)].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0 ..< cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: Fix
    }
    
    init (numberOfPairsOfCards: Int, createContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(content: createContent(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: createContent(pairIndex), id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
