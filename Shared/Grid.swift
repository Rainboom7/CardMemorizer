//
//  Grid.swift
//  CardMemorizer
//
//  Created by Admin on 21.11.2022.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {

    private var items: [Item]
    private var itemView: (Item) -> ItemView

    init(items: [Item], itemView: @escaping ((Item) -> ItemView)) {
        self.items = items
        self.itemView = itemView
    }

    var body: some View {
        GeometryReader { geometry in
            createBody(in: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }

    private func createBody(in layout: GridLayout) -> some View {
        ForEach(items) { item in
            itemBody(for: item, in: layout)
        }
    }

    private func itemBody(for item: Item, in layout: GridLayout) -> some View {
        let itemIndex = indexOf(item)
        return itemView(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: itemIndex))
    }

    func indexOf(_ item: Item) -> Int {
        return items.firstIndex(matching: item) ?? 0
    }

}

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        return firstIndex { (element) -> Bool in
            element.id == matching.id
        }
    }
}
