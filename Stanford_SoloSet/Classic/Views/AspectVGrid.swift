//
//  AspectVGrid.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 26/07/2021.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var spacing: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, spacing: CGFloat = 5.0, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LazyVGrid(columns: [adaptiveGridItem(width: widthThatFits(in: geometry.size))], spacing: spacing) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = spacing
        return gridItem
    }
    
    private func widthThatFits(in size: CGSize) -> CGFloat {
        let itemCount = items.count

        var columns = 1
        var rows = itemCount
        
        var width: CGFloat
        var height: CGFloat
        
        repeat {
            width = (size.width - (spacing * CGFloat(columns - 1))) / CGFloat(columns)
            
            height = width / aspectRatio
            
            if (CGFloat(rows) * height) + (spacing * CGFloat(rows - 1)) < size.height {
                break
            }
            columns += 1
            rows = (itemCount + (columns - 1)) /  columns
            //rows = itemCount /  columns
        } while columns < itemCount
        
        if columns > itemCount {
            columns = itemCount
        }
        
        return floor((size.width - (spacing * CGFloat(columns - 1))) / CGFloat(columns))
    }
}

struct AspectVGrid_Previews: PreviewProvider {
    static var previews: some View {
        AspectVGrid(items: ClassicSoloSetGame().dealtCards, aspectRatio: 2/3) { card in
            CardView(card: card, colorBlind: .constant(false))
        }
    }
}

