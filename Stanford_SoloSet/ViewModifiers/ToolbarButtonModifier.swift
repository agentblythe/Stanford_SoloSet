//
//  BottomToolbarModifier.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 26/07/2021.
//

import SwiftUI

struct ToolbarButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 3))
    }
}

extension View {
    func toolbarButton() -> some View {
        self.modifier(ToolbarButtonModifier())
    }
}
