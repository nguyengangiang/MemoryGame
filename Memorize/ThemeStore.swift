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
        self.themes = themes
        let defaultsKey = "MemoryGameStore.\(name)"
//        autosave = $themes.sink { themes in
//            UserDefaults.standard.setValue(themes.self, forKey: defaultsKey)
//        }
    }
    
    
    init?(json: Data?) {
        if json != nil, let newThemes = try? JSONDecoder().decode([Theme].self, from: json!) {
            self.themes = newThemes
            self.name = "Untitled"
        } else {
            return nil
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
    
    func setName(_ name: String, for theme: EmojiMemoryGame) {
        theme.rename(name: name)
    }
    
    func removeTheme(theme: Theme) {
        themes.remove(at: themes.firstIndex(matching: theme)!)
    }
    
}
