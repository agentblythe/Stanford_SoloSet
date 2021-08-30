//
//  View+ColoredWith.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 24/07/2021.
//

import SwiftUI

extension View {
    func colored(with color: Card.ValidColor) -> some View {
        self.modifier(ShapeColorModifier(shapeColor: color))
    }
}
