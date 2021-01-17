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
        var color: UIColor

        switch theme {
        case .halloween:
            name = "Halloween"
            emojis = ["👻", "💀", "😈", "🎃", "👹"]
            color = UIColor.orange
        case .organs:
            name = "Organs"
            emojis = ["🫀", "🫁", "🧠"]
            color = UIColor.red
        case .chicken:
            name = "Chicken"
            emojis = ["🐓", "🐔", "🐤", "🐣", "🐥"]
            color = UIColor.yellow
        case .notHuman:
            name = "Not Human"
            emojis = ["🦸", "🦹", "🧑‍🎄", "🧙", "🧝", "🧛", "🧟", "🧞"]
            color = UIColor.black
        case .animal:
            name = "Animal"
            emojis = ["🦍", "🦧", "🐆", "🦒", "🐈‍⬛", "🦓"]
            color = UIColor.green
        case .flower:
            name = "Flower"
            emojis = ["🌸", "💐", "🌷", "🌹", "🌺", "🌼", "🌻"]
            color = UIColor.magenta
        }
        

        
        let numberOfPairsOfCards = emojis.count
        return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards, themeName: name, color: UIColor.RGB.init(red: color.rgb.red, green: color.rgb.green, blue: color.rgb.blue, alpha: color.rgb.alpha), createContent: {index in
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
        print("json: \(model.json?.utf8 ?? "nil")")
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
        Color(model.color)
    }
    
    var numberOfPairsOfCards: Int {
        model.cards.count
    }
    
    var score: Int {
        model.score
    }
}
