//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/24/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    var body: some Scene {
        let themes = [Theme]()
        let themeStore = ThemeStore(themes: themes)
        //themeStore.addTheme(theme: EmojiMemoryGame.flower)
        themeStore.addTheme(theme: EmojiMemoryGame.organs)
        themeStore.addTheme(theme: EmojiMemoryGame.chicken)
        themeStore.addTheme(theme: EmojiMemoryGame.notHuman)
        print("id = {\(themeStore.themes.map{$0.id})}")
        return WindowGroup {
            ThemeChooser(themeStore: themeStore)
        }
    }
}
