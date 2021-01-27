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
    @Environment(\.presentationMode) var presentation
    
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

                    .popover(isPresented: $showThemeEditor) {
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
                        } label: { Text("Add") }

                    }
                })
                Section(header: Text("Emojis"), footer: Text("Tap to remove")) {
                    Grid(themeStore.themes[themeStore.themes.firstIndex(matching: chosenTheme)!].emojis, id: \.self) { emoji in
                        Text(emoji).font(Font.system(size: fontSize))
                            .onTapGesture {
                                themeStore.removeEmoji(emoji, from: chosenTheme)
                            }
                    }
                    .frame(height: height)
                }
                Section(header: Text("Card Count")) {
                    Stepper {
                        themeStore.incrementCardPair(for: chosenTheme)
                    } onDecrement: {
                        themeStore.decrementCardPair(for: chosenTheme)
                    } label: {
                        Text("\(themeStore.themes[themeStore.themes.firstIndex(matching: chosenTheme)!].numberOfPairsOfCards) Pairs")
                    }
                }
                
                Section(header: Text("Color")) {
                    Grid(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 5).foregroundColor(color)
                            .onTapGesture {
                                themeStore.themes[themeStore.themes.firstIndex(matching: chosenTheme)!].setColor(color)
                            }
                            .padding(5)
                    }
                    .frame(height: height)
                }
            }
        }
    }
    
    // MARK: Drawing constants
    var fontSize: CGFloat = 40
    var height: CGFloat {
        CGFloat((chosenTheme.emojis.count - 1) / 6) * 70 + 70
    }
    var colors = [Color.blue, Color.gray, Color.green, Color.orange, Color.pink, Color.purple, Color.red, Color.yellow]
}

struct ThemeChooser_Preview:  PreviewProvider {
    static var previews: some View {
        var themes = [Theme]()
        themes.append(Theme.halloween)
        return ThemeChooser()
            .environmentObject(ThemeStore(themes: themes))
    }
}

