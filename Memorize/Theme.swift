//
//  Theme.swift
//  Memorize
//
//  Created by Giang Nguyenn on 1/24/21.
//

import Foundation
import SwiftUI

struct Theme: Codable, Identifiable {
    
    var themeName: String
    var emojis: [String]
    var color: UIColor.RGB
    var numberOfPairsOfCards: Int
    var id: UUID
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newTheme = try? JSONDecoder().decode(Theme.self, from: json!) {
            self = newTheme
        } else {
            return nil
        }
    }
    
    init() {
        self.themeName = "Face"
        self.emojis = ["😳", "🙄", "😏", "🥺"]
        self.color = UIColor(Color.gray).rgb
        self.numberOfPairsOfCards = emojis.count
        self.id = UUID()
    }
    
    init(name: String, emojis: [String], color: Color) {
        self.themeName = name
        self.emojis = emojis
        self.color = UIColor(color).rgb
        self.id = UUID()
        self.numberOfPairsOfCards = emojis.count
    }
    
    mutating func addEmoji(_ emoji: String) {
        var emojiSet = Set<String>()
        for e in emojis {
            emojiSet.insert(e)
        }
        for e in emoji {
            emojiSet.insert(String(e))
        }
        self.emojis = Array(emojiSet)
    }
    
    mutating func rename(to name: String) {
        themeName = name
    }
    
    mutating func removeEmoji(_ emoji: String){
        var emojiSet = Set<String>()
        for e in emojis {
            emojiSet.insert(e)
        }
        emojiSet.remove(emoji)
        self.emojis = Array(emojiSet)
    }
    
    mutating func incrementCardCount() {
        if (numberOfPairsOfCards < emojis.count) {
            numberOfPairsOfCards += 1
        }
    }
    
    mutating func decrementCardCount() {
        if (numberOfPairsOfCards > 2) {
            numberOfPairsOfCards -= 1
        }
    }
}

extension Theme {
    static var halloween: Theme {
        Theme(name: "Halloween", emojis: ["👻", "💀", "😈", "🎃", "👹"], color: Color.orange )
    }
    
    static var organs: Theme {
        Theme(name: "Organs", emojis: ["🫀", "🫁", "🧠"], color: Color.red)
    }
    
    static var chicken: Theme {
        Theme(name: "Chicken", emojis: ["🐓", "🐔", "🐤", "🐣", "🐥"], color: Color.yellow)
    }
    
    static var notHuman: Theme {
        Theme(name: "Not Human", emojis: ["🦸", "🦹", "🧑‍🎄", "🧙", "🧝", "🧛", "🧟", "🧞"], color: Color.black)
    }
    
    static var animal: Theme {
        Theme(name: "Animal", emojis: ["🦍", "🦧", "🐆", "🦒", "🐈‍⬛", "🦓"], color: Color.green)
    }
    
    static var flower: Theme {
        Theme(name: "Flower", emojis: ["🌸", "💐", "🌷", "🌹", "🌺", "🌼", "🌻"], color: Color.pink)
    }
}
