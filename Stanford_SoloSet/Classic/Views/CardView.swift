//
//  CardView.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    @Binding var colorBlind: Bool
    
    var isFaceUp = true
    
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

//
//                if colorBlind {
//                    VStack {
//                        Text("\(card.color.rawValue)")
//                            .font(font(in: size))
//                            .underline()
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
    
    
    var cardContent: some View {
        ZStack {
            cardShape.fill(Color.white)
            cardShape.strokeBorder(Color.black)
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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                cardContent
//                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
//                    .animation(Animation.easeInOut)
            }
            .cardify(
                isFaceUp: card.isFaceUp,
                isMatched: card.isMatched,
                isNotMatched: card.isNotMatched,
                isSelected: card.isSelected,
                isHint: card.isHint)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.1)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.exampleCard, colorBlind: .constant(true))
    }
}

