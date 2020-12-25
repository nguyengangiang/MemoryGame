//
//  MemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    func choose(card: Card) {
        print("Card chosen: \(card)")
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatch: Bool
        var content: CardContent
    }
}
