//
//  Cardify.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/30/20.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
