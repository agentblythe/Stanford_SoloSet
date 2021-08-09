//
//  AspectVGrid.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 26/07/2021.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    
    var items: [Item]
    var aspectRatio: CGFloat
    var minimumWidth: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, minimumWidth: CGFloat = 80.0, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.minimumWidth = minimumWidth
        self.content = content
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    let width = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0.0, content: {
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                        
                    })
                    Spacer(minLength: 0)
                }
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        GridItem(.adaptive(minimum: width), spacing: 0.0)
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        let calculatedWidth = floor(size.width / CGFloat(columnCount))
        return max(minimumWidth, calculatedWidth)
    }
}

struct AspectVGrid_Previews: PreviewProvider {
    static var previews: some View {
        AspectVGrid(items: ClassicSoloSetGame().dealtCards, aspectRatio: 2/3) { card in
            CardView(card: card, colorBlind: .constant(false))
        }
    }
}

