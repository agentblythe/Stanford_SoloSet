//
//  Color.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import SwiftUI

extension Color {
    init(from validColor: Card.ValidColor) {
        switch validColor {
        case .green:
            self = .green
        case .pink:
            self = .pink
        case .purple:
            self = .purple
        }
    }
}
