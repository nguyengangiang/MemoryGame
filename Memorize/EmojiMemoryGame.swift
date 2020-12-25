//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation

class EmojiMemoryGame {
    private var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String>{
        let emojis = ["👻", "💀"]
        return MemoryGame(numberOfPairsOfCards: emojis.count, createContent: {index in
            emojis[index]
        })
    }
    
    //MARK: Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    //MARK: Access
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var numberOfPairsOfCards: Int {
        model.cards.count
    }
    
    
    
}
