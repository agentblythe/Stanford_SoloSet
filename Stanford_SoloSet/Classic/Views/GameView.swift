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
        static let minimumCardWidth: CGFloat = 85.0
    }
    
    var body: some View {
        AspectVGrid(items: game.undealtCards, aspectRatio: DrawingConstants.aspectRatio, spacing: DrawingConstants.cardSpacing, minimumCardWidth: DrawingConstants.minimumCardWidth) { card in
            CardView(card: card)
        }
    
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
//                ForEach(game.undealtCards) { card in
//                    CardView(card: card)
//                        .aspectRatio(DrawingConstants.aspectRatio, contentMode: .fill)
//                }
//            }
//        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: ClassicSoloSetGame())
    }
}
