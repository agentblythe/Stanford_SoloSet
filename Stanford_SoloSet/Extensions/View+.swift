//
//  View.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 24/07/2021.
//

import SwiftUI

extension View {
    func colored(with validColor: Card.ValidColor) -> some View {
        self.modifier(ShapeColorModifier(shapeColor: validColor))
    }
}

extension View {
    func shaded(with shading: Card.Shading) -> some View {
        self.modifier(ShapeShadingModifier(shading: shading))
    }
}
