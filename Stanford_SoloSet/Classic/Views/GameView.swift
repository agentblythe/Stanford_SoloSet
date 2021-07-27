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
        static let minimumCardWidth: CGFloat = 50.0
    }
    
    var hintButton: some View {
        Button(action: {
            
        }, label: {
            Text("Hint")
        })
    }
    
    var dealButton: some View {
        Button(action: {
            game.dealMoreCards()
        }, label: {
            Text("Deal 3")
        })
    }
    
    var newGameButton: some View {
        Button(action: {
            game.resetGame()
        }, label: {
            Text("New Game")
        })
    }
    
    var topToolbar: some View {
        HStack {
            Text("Matched Cards: \(game.discardCards.count)")
            
            Spacer()
            
            Text("Undealt cards: \(game.undealtCards.count)")
        }
        .padding(.horizontal)
    }
    
    var bottomToolbar: some View {
        HStack(spacing: 0.0) {
            hintButton
                .toolbarButton()
                .frame(minWidth: 0, maxWidth: .infinity)
  
            dealButton
                .toolbarButton()
                .disabled(game.undealtCards.count == 0)
                .frame(minWidth: 0, maxWidth: .infinity)
  
            newGameButton
                .toolbarButton()
                .frame(minWidth: 0, maxWidth: .infinity)

        }
        .foregroundColor(Color.black).font(.headline)

    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                topToolbar
                
                AspectVGrid(items: game.dealtCards, aspectRatio: 2/3) { card in
                    CardView(card: card)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            game.select(card)
                        }
                        .padding(2)

                }
                .frame(maxHeight: geometry.size.height * 0.9)
                
                bottomToolbar
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: ClassicSoloSetGame())
    }
}
