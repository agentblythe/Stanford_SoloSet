//
//  ShadingModifier.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 24/07/2021.
//

import SwiftUI

struct ShapeColorModifier: ViewModifier {
    var shapeColor: Card.ValidColor

    func body(content: Content) -> some View {
        content.foregroundColor(Color(from: shapeColor))
    }
}
