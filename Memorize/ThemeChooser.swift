//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Giang Nguyenn on 1/24/21.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var themeStore: ThemeStore
    
    @State var editMode: EditMode = .inactive
    @State private var showThemeEditor = false
    
    var body: some View {
        let themes = themeStore.themes
        return NavigationView {
            return List {
                ForEach(themes) { theme in
                    let emojiMemoryView = EmojiMemoryView(viewModel: EmojiMemoryGame(theme: theme), chosenTheme: theme)
                    NavigationLink(destination: emojiMemoryView.navigationBarTitle(theme.themeName)) {
                       // VStack {
                            HStack {
                                Image(systemName: "pencil.circle.fill")
                                    .imageScale(.large)
                                    .onTapGesture {
                                        showThemeEditor = true
                                    }
                                    .sheet(isPresented: $showThemeEditor) {
                                        ThemeEditor(isShowing: $showThemeEditor, chosenTheme: theme)
                                            .environmentObject(themeStore)
                                    }
                                Text(theme.themeName)
                            }
//                            HStack {
//                                ForEach(theme.emojis.map {String($0)}) { emoji in
//                                    Text(emoji)
//                                }
//                            }
//                        }

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
    @EnvironmentObject var themeStore: ThemeStore
    @Binding var isShowing: Bool
    @State var chosenTheme: Theme
    @State var themeName = ""
    @State var emojisToAdd = ""
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(chosenTheme.themeName)").font(.headline).padding()
                HStack {
                    Spacer()
                    Button { isShowing = false }
                        label: { Text("Done").padding() }
                }

            }
            Divider()
            Form() {
                Section() {
                    TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                        if !began {
                            themeStore.setName(themeName, for: chosenTheme)
                        }
                    })
                    Text("Add Emoji")
                    HStack {
                        TextField("Emoji", text: $emojisToAdd)
                        Button {
                            themeStore.addEmoji(emojisToAdd, to: chosenTheme)
                            emojisToAdd = ""
                        } label: { Text("Done") }

                    }

                }
            }
            
        }
    }
}
