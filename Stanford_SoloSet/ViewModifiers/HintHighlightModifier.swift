//
//  HintHighlightModifier.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 30/07/2021.
//

import SwiftUI

struct HintHighlightModifier: ViewModifier {
    var highlight: Bool
    
    func body(content: Content) -> some View {
        if highlight {
            content
                .foregroundColor(.orange)
        } else {
            content
        }
    }
}

extension View {
    func highlight(highlight : Bool) -> some View {
        self.modifier(HintHighlightModifier(highlight: highlight))
    }
}
