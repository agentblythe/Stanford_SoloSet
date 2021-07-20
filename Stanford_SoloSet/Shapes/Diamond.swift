//
//  Diamond.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 19/07/2021.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        let left = CGPoint(x: centre.x - radius, y: centre.y)
        let bottom = CGPoint(x: centre.x, y: centre.y + radius)
        let right = CGPoint(x: centre.x + radius, y: centre.y)
        let top = CGPoint(x: centre.x, y: centre.y - radius)
        
        var p = Path()
        
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        
        return p
    }
}
