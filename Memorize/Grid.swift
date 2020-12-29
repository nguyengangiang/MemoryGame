//
//  Grid.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/28/20.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    var items = [Item]()
    var viewForItem: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(itemCount: items.count, in: geometry.size)
            ForEach(items) { item in
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height, alignment: .center)
                    .position(layout.location(ofItemAt: items.firstIndex(matching: item)!))
            }
        }
    }
}
