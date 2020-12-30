//
//  MemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: [Card]
    private(set) var name: String
    private(set) var color: Color
    private(set) var score: Int

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
                    score += 2

                } else {
                    if cards[chosenIndex].isSeen == true {
                        score -= 1
                    }
                    if (cards[potentialMatched].isSeen == true){
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].isSeen = true
                cards[potentialMatched].isSeen = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init (numberOfPairsOfCards: Int, themeName: String, color: Color, createContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(content: createContent(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: createContent(pairIndex), id: pairIndex * 2 + 1))
        }
        cards.shuffle()
        name = themeName
        self.color = color
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var isSeen: Bool = false
    }
}
