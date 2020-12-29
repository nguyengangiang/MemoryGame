//
//  MemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: [Card]
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{cards[$0].isFaceUp}.only
        }
        set {
            for index in 0 ..< cards.count {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched, !cards[chosenIndex].isFaceUp {
            if let potentialMatched = indexOfTheOneAndOnlyFaceUpCard {
                if (cards[potentialMatched].content == cards[chosenIndex].content) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatched].isMatched = true
                    print("Card chosen: \(cards[chosenIndex])")
                    print("Card potential: \(cards[potentialMatched])")

                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
