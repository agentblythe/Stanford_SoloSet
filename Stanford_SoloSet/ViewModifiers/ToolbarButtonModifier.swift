//
//  BottomToolbarModifier.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 26/07/2021.
//

import SwiftUI

//
// View Modifier to style a view, typically a button
// to have a "Toolbar" style
//
struct ToolbarButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 3))
    }
}

