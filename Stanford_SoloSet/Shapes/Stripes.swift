//
//  Stripes.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 22/07/2021.
//

import SwiftUI

struct StripedPattern: Shape {
    
    var widthOfStripe: Int
    
    func path(in rect: CGRect) -> Path {
        let numberOfStripes = Int(rect.width) / widthOfStripe
        
        var path = Path()
        
        path.move(to: rect.origin)
        
        for index in 0...numberOfStripes {
            if index % 2 == 0 {
                path.addRect(CGRect(
                    x: index * widthOfStripe,
                    y: 0,
                    width: widthOfStripe,
                    height: Int(rect.height)))
            }
        }
        return path.scale(2.0).transform(.init(rotationAngle: CGFloat(Angle(degrees: 10.0).radians))).path(in: rect)
    }
        
}

struct Striped_Previews: PreviewProvider {
    static var previews: some View {
        StripedPattern(widthOfStripe: 2)
    }
}
