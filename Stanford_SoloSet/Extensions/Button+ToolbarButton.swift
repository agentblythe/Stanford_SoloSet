//
//  Button+ToolbarButton.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 29/08/2021.
//

import SwiftUI

extension Button {
    func toolbarButton() -> some View {
        self.modifier(ToolbarButtonModifier())
    }
}
