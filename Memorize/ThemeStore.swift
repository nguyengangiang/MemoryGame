//
//  ThemeStore.swift
//  Memorize
//
//  Created by Giang Nguyenn on 1/24/21.
//

import Foundation
import Combine

class ThemeStore: ObservableObject {
    @Published var themes: [Theme]
    var name: String
    private var autosave: AnyCancellable?
    
    init(named name: String = "Memory Game", themes: [Theme]) {
        self.name = name
        let defaultsKey = "MemoryStore.\(name)"
        self.themes = Array(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey))
        autosave = $themes.sink { themes in
            UserDefaults.standard.set(themes.asPropertyList, forKey: defaultsKey)
        }
    }
    
    func name(for theme: EmojiMemoryGame) -> String {
        return theme.themeName
    }
    
    func addTheme(theme: Theme) {
        themes.append(theme)
    }
    
    func addTheme() {
        themes.append(Theme())
    }
    
    func setName(_ name: String, for theme: Theme) {
        themes[themes.firstIndex(matching: theme)!].rename(to: name)
    }
    
    func addEmoji(_ emojis: String, to theme: Theme) {
        themes[themes.firstIndex(matching: theme)!].addEmoji(emojis)
    }
    
    func removeTheme(theme: Theme) {
        themes.remove(at: themes.firstIndex(matching: theme)!)
    }
    
    func removeEmoji(_ emoji: String, from theme: Theme) {
        themes[themes.firstIndex(matching: theme)!].removeEmoji(emoji)
    }
    
    func incrementCardPair(for theme: Theme) {
        themes[themes.firstIndex(matching: theme)!].incrementCardCount()
    }
    
    func decrementCardPair(for theme: Theme) {
        themes[themes.firstIndex(matching: theme)!].decrementCardCount()
    }
    
}

extension Array where Element == Theme {
    var asPropertyList: [Data?] {
        var dataArray = [Data?]()
        for (element) in self {
            dataArray.append(element.json)
        }
        return dataArray
    }
    
    init(fromPropertyList plist: Any?) {
        self.init()
        let dataArray = plist as? [Data?] ?? []
        for data in dataArray {
            self.append(Theme(json: data)!)
        }
    }
}
