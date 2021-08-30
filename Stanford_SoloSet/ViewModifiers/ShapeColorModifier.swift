//
//  ShadingModifier.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 24/07/2021.
//

import SwiftUI

//
// View Modifier to apply a colour to a Shape
//
struct ShapeColorModifier: ViewModifier {
    var shapeColor: Card.ValidColor

    func body(content: Content) -> some View {
        content.foregroundColor(Color(from: shapeColor))
    }
}
