//
//  CardView.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var number: Int {
        card.number.rawValue
    }
    
    var shape: Card.Shape {
        card.shape
    }
    
    var shading: Card.Shading {
        card.shading
    }
    
    var color: Card.ValidColor {
        card.color
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10.0
        static let lineWidth: CGFloat = 2.0
        static let fontScale: CGFloat = 0.75
        static let piePadding: CGFloat = 5
        static let pieOpacity: Double = 0.5
        static let shapeAspectRatio: CGFloat = 2/1
    }
    
    private let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)

    private func front(of card: Card, in size: CGSize) -> some View {
        ZStack {
            cardShape.strokeBorder()
            VStack {
                ForEach(0..<self.number, id: \.self) {_ in
                    ZStack {
                        ShapeView(shape: card.shape)
                            .stroke(lineWidth: 5.0)
                            .colored(with: color)
                        ShapeView(shape: card.shape)
                            .shaded(with: shading)
                            .colored(with: color)
                    }
                    .aspectRatio(DrawingConstants.shapeAspectRatio, contentMode: .fit)
                }
            }
            .padding()
        }
    }
    
    private func back(of card: Card, in size: CGSize) -> some View {
        cardShape.fill()
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isSelected {
                if card.isMatched {
                    front(of: card, in: geometry.size)
                        .border(Color.green, width: 5)
                } else if card.isNotMatched {
                    front(of: card, in: geometry.size)
                        .border(Color.red, width: 5)
                } else {
                    front(of: card, in: geometry.size)
                        .border(Color.blue, width: 5)
                }
            } else {
                front(of: card, in: geometry.size)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.exampleCard)
    }
}

