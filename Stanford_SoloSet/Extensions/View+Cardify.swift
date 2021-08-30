//
//  View+Cardify.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 23/08/2021.
//

import SwiftUI

extension View {
    public func cardify(isFaceUp: Bool,
                        isMatched: Bool,
                        isNotMatched: Bool,
                        isSelected: Bool,
                        isHint: Bool) -> some View {
        self.modifier(CardifyModifier(isFaceUp: isFaceUp,
                              isMatched: isMatched,
                              isNotMatched: isNotMatched,
                              isSelected: isSelected,
                              isHint: isHint))
    }
    
    public func cardify(isFaceUp: Bool) -> some View {
        self.modifier(CardifyModifier(isFaceUp: isFaceUp,
                              isMatched: false,
                              isNotMatched: false,
                              isSelected: false,
                              isHint: false))
    }
}
