//
//  Diamond.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 19/07/2021.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
    }
}
