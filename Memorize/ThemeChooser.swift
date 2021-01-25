//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Giang Nguyenn on 1/24/21.
//

import SwiftUI

struct ThemeChooser: View {
    @State var editMode: EditMode = .inactive
    @State var themeStore: ThemeStore
    @State private var showThemeEditor = false
    
    var body: some View {
        let themes = themeStore.themes
        return NavigationView {
            List {
                ForEach(themes) { theme in
                    NavigationLink(destination:EmojiMemoryView(viewModel: EmojiMemoryGame(theme: theme)).navigationBarTitle(theme.themeName)) {
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                                .imageScale(.large)
                                .onTapGesture {
                                    showThemeEditor = true
                                }
                                .sheet(isPresented: $showThemeEditor) {
                                    ThemeEditor(isShowing: $showThemeEditor, themeName: theme.themeName)
                                        .environmentObject(EmojiMemoryGame(theme: theme))
                                }
                            Text(theme.themeName)
                        }
                        .foregroundColor(Color(theme.color))
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { themeStore.themes[$0] }.forEach { theme in
                        themeStore.removeTheme(theme: theme)
                    }
                }
            }
            .navigationTitle(themeStore.name)
            .navigationBarItems(
                leading: Button(action: {
                    themeStore.addTheme()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
}



struct ThemeEditor: View {
    @EnvironmentObject var emojiMemoryGame: EmojiMemoryGame
    @Binding var isShowing: Bool
    @State var themeName = ""
    var body: some View {
        Text("\(emojiMemoryGame.themeName)")
    }
}
