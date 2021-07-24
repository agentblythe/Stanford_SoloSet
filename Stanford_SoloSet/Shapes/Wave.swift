//
//  Wave.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 20/07/2021.
//

import SwiftUI

struct Wave: Shape {
    
    private struct DrawingConstants {
        static let leftY: CGFloat = 0.8
        static let rightY: CGFloat = 1 - leftY
        static let leftX: CGFloat = 0.2
        static let rightX: CGFloat = 1 - leftX
        static let leftYInset: CGFloat = 0.01
        static let rightYInset: CGFloat = 1 - leftYInset
        static let leftCurveX: CGFloat = 0.4
        static let rightCurveX: CGFloat = 1 - leftCurveX
        static let leftCurveY: CGFloat = 0.4
        static let rightCurveY: CGFloat = 1 - leftCurveY
    }
    
    func path(in rect: CGRect)-> Path{
        
        let width  = rect.width
        let height = rect.height
        
        let a = CGPoint(x: rect.minX, y: height * DrawingConstants.leftY)
        let b = CGPoint(x: rect.minX + width * DrawingConstants.leftX, y: rect.minY + height * DrawingConstants.leftYInset)
        let e = CGPoint(x: rect.maxX, y: height * DrawingConstants.rightY)
        let f = CGPoint(x: rect.maxX * DrawingConstants.rightX, y: rect.maxY * DrawingConstants.rightYInset)
    
        let c = CGPoint(x: rect.width * DrawingConstants.leftCurveX, y: rect.height * DrawingConstants.leftCurveY)
        let d = CGPoint(x: rect.width * DrawingConstants.rightCurveX, y: rect.minY)
        
        let g = CGPoint(x: d.x, y: rect.height * DrawingConstants.rightCurveY)
        let h = CGPoint(x: c.x, y: rect.height)
        
        var p = Path()
        p.move(to: a)
        p.addLine(to: b)
        p.addCurve(to: e, control1: c, control2: d)
        p.addLine(to: f)
        p.addCurve(to: a, control1: g, control2: h)
        return p
    }
}

struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        Wave()
    }
}
