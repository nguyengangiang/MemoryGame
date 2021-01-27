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
        return WindowGroup {
            ThemeChooser().environmentObject(themeStore)
        }
    }
}
