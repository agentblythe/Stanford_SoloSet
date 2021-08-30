//
//  View+ShadedWith.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 23/08/2021.
//

import SwiftUI

extension View {
    func shaded(with shading: Card.Shading) -> some View {
        self.modifier(ShapeShadingModifier(shading: shading))
    }
}
