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
    @State var chosenTheme = Theme()
    
    var body: some View {
        let themes = themeStore.themes
        return NavigationView {
            List {
                ForEach(themes) { theme in
                    let emojiMemoryView = EmojiMemoryView(viewModel: EmojiMemoryGame(theme: theme), chosenTheme: theme)
                    NavigationLink(destination: emojiMemoryView.navigationBarTitle(theme.themeName)) {
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                                .imageScale(.large)
                                .onTapGesture {
                                    if editMode.isEditing {
                                        showThemeEditor = true
                                        self.chosenTheme = theme
                                    }
                                }
                                .scaleEffect(editMode.isEditing ? 1 : 0)
                            VStack {
                                Text(theme.themeName)
                                Text("\(theme.numberOfPairsOfCards) pairs of \(theme.emojis.joined())")
                            }
                            .multilineTextAlignment(.leading)
                        }
                        .foregroundColor(Color(theme.color))
                    }

                    .sheet(isPresented: $showThemeEditor) {
                        ThemeEditor(isShowing: $showThemeEditor, chosenTheme: $chosenTheme)
                            .environmentObject(themeStore)
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
    @Binding var chosenTheme: Theme
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
                TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                    if !began {
                        themeStore.setName(themeName, for: chosenTheme)
                    }
                })
                Section(header: Text("Add Emoji"), content: {
                    HStack {
                        TextField("Emoji", text: $emojisToAdd)
                        Button {
                            themeStore.addEmoji(emojisToAdd, to: chosenTheme)
                            emojisToAdd = ""
                        } label: { Text("Done") }

                    }
                })
                Section(header: Text("Emojis"), footer: Text("Tap to remove")) {
                    HStack {
                        ForEach(themeStore.themes[themeStore.themes.firstIndex(matching: chosenTheme)!].emojis, id: \.self) { emoji in
                            Text(emoji)
                                .onTapGesture {
                                    themeStore.removeEmoji(emoji, from: chosenTheme)
                                }
                        }
                    }
                }
                Section(header: Text("Card Count")) {
                    Stepper {
                        themeStore.themes[themeStore.themes.firstIndex(matching: chosenTheme)!].incrementCardCount()
                    } onDecrement: {
                        themeStore.themes[themeStore.themes.firstIndex(matching: chosenTheme)!].decrementCardCount()
                    } label: {
                        Text("\(themeStore.themes[themeStore.themes.firstIndex(matching: chosenTheme)!].numberOfPairsOfCards) Pairs")
                    }


                }
            }
        }
    }
}

struct ThemeChooser_Preview:  PreviewProvider {
    static var previews: some View {
        var themes = [Theme]()
        themes.append(Theme.halloween)
        return ThemeChooser()
            .environmentObject(ThemeStore(themes: themes))
    }
}

