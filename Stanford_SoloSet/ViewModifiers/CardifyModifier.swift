//
//  Cardify.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 23/08/2021.
//

import SwiftUI

struct CardifyModifier: AnimatableModifier {
    
    init(isFaceUp: Bool,
         isMatched: Bool,
         isNotMatched: Bool,
         isSelected: Bool,
         isHint: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isMatched = isMatched
        self.isNotMatched = isNotMatched
        self.isSelected = isSelected
        self.isHint = isHint
    }
    
    var isMatched: Bool
    
    var isNotMatched: Bool
    
    var isSelected: Bool
    
    var isHint: Bool
    
    var rotation: Double // in degrees

    // Tell the system to animate the data but we will determine how this looks
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
    
    func body(content: Content) -> some View {
        ZStack {
            content.opacity(rotation < 90 ? 1 : 0)
            
            if rotation < 90 {
                cardShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                cardShape.fill(Color.black)
            }
            
            if isSelected {
                if isMatched {
                    cardShape.stroke(Color.green, lineWidth: 5)
                } else if isNotMatched {
                    cardShape.stroke(Color.red, lineWidth: 5)
                } else {
                    cardShape.stroke(Color.blue, lineWidth: 5)
                }
            }
            
            if isHint {
                cardShape.stroke(Color.orange, lineWidth: 5)
            }
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10.0
        static let lineWidth: CGFloat = 2.0
    }
    
}
