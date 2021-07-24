//
//  GameView.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 20/07/2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: ClassicSoloSetGame
    
    private struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let cardSpacing: CGFloat = 5.0
        static let minimumCardWidth: CGFloat = 100.0
    }
    
    var body: some View {
        AspectVGrid(items: game.dealtCards, aspectRatio: DrawingConstants.aspectRatio, spacing: DrawingConstants.cardSpacing, minimumCardWidth: DrawingConstants.minimumCardWidth) { card in
            CardView(card: card)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: ClassicSoloSetGame())
    }
}
