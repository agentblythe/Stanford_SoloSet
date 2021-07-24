//
//  ShapeShadingModifier.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 24/07/2021.
//

import SwiftUI

struct ShapeShadingModifier: ViewModifier {
    var shading: Card.Shading
    
    func body(content: Content) -> some View {
        switch shading {
        case .none:
            content
                .foregroundColor(.clear)
        case .stripes:
            StripedPattern(widthOfStripe: 10).mask(content)
        case .fill:
            content
        }
    }
}
