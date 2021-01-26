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
        self.id = UUID()
    }
    
    init(name: String, emojis: [String], color: Color) {
        self.themeName = name
        self.emojis = emojis
        self.color = UIColor(color).rgb
        self.id = UUID()
    }
    
    mutating func addEmoji(_ emoji: String) {
        for e in emoji {
            emojis.append(String(e))
        }
    }
    
    mutating func rename(to name: String) {
        themeName = name
    }
}

extension EmojiMemoryGame {
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
