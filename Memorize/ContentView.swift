//
//  ContentView.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/24/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        return HStack() {
            ForEach(0..<4) { index in
                CardView()
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack() {
            if isFaceUp {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                    RoundedRectangle(cornerRadius: 10).fill(Color.white)
                    Text("💀").font(Font.largeTitle)
                }
            else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
