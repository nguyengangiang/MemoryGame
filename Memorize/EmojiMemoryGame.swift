//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject{
    @Published private var model: MemoryGame<String> = createMemoryGame(theme: Theme.halloween)
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String>{
        var emojis: [String]
        var name : String
        var color: Color

        switch theme {
        case .halloween:
            name = "Halloween"
            emojis = ["👻", "💀", "😈", "🎃", "👹"]
            color = Color.orange
        case .organs:
            name = "Organs"
            emojis = ["🫀", "🫁", "🧠"]
            color = Color.red
        case .chicken:
            name = "Chicken"
            emojis = ["🐓", "🐔", "🐤", "🐣", "🐥"]
            color = Color.yellow
        case .notHuman:
            name = "Not Human"
            emojis = ["🦸", "🦹", "🧑‍🎄", "🧙", "🧝", "🧛", "🧟", "🧞"]
            color = Color.black
        case .animal:
            name = "Animal"
            emojis = ["🦍", "🦧", "🐆", "🦒", "🐈‍⬛", "🦓"]
            color = Color.green
        case .flower:
            name = "Flower"
            emojis = ["🌸", "💐", "🌷", "🌹", "🌺", "🌼", "🌻"]
            color = Color.pink
        }
        
        let numberOfPairsOfCards = Int.random(in: 2 ... emojis.count)
        return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards, themeName: name, color: color, createContent: {index in
            emojis[index]
        })
    }
    
    enum Theme: CaseIterable {
        case halloween
        case organs
        case chicken
        case notHuman
        case animal
        case flower
    }
        
    //MARK: Intent(s)
    func newGame() {
        let randomTheme = Theme.allCases.randomElement()
        model = EmojiMemoryGame.createMemoryGame(theme: randomTheme!)
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    //MARK: Access
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeName: String {
        model.name
    }
    
    var color: Color {
        model.color
    }
    
    var numberOfPairsOfCards: Int {
        model.cards.count
    }
    
    var score: Int {
        model.score
    }
}
