//
//  ShapeView.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 24/07/2021.
//

import SwiftUI

struct ShapeView: Shape {
    
    var shape: Card.Shape
    
    func path(in rect: CGRect) -> Path {
        switch shape {
        case .diamond:
            return Diamond().path(in: rect)
        case .wave:
            return Wave().path(in: rect)
        case .capsule:
            return RoundedRectangle(cornerRadius: 25).path(in: rect)
        }
    }
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeView(shape: .diamond)
    }
}
