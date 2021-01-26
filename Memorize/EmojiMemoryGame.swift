//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation
import SwiftUI
import Combine

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame(theme: Theme())

    static func createMemoryGame(theme: Theme) -> MemoryGame<String>{
        let emojis = theme.emojis
        let name = theme.themeName
        let color = theme.color
        let numberOfPairsOfCards = emojis.count
        
        return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards, themeName: name, color: color, createContent: { index in
            emojis[index]
        })
    }
    
    private var autosaveCancellable: AnyCancellable?
    
    init(name: String) {
        let defaultsKey = "EmojiMemoryGame.\(name)"
        autosaveCancellable = $model.sink { model in
            UserDefaults.standard.setValue(model.json, forKey: defaultsKey)
        }
    }
    
    init(theme: Theme) {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
        
    //MARK: Intent(s)
    func newGame(theme: Theme) {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func rename(name: String) {
        self.model.name = name
    }
    
    //MARK: Access
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeName: String {
        model.name
    }
    
    var color: Color {
        Color(model.color)
    }
    
    var numberOfPairsOfCards: Int {
        model.cards.count
    }
    
    var score: Int {
        model.score
    }
}
