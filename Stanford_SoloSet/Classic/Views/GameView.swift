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
    
    @State var showHint = false
    
    @State var colorBlind = false
    
    @State var showingSettings = false
    
    var availableSet: [Card]! {
        return game.firstAvailableSet
    }
    
    var hintButton: some View {
        Button(action: {
            showHint.toggle()
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
            Text("Sets Found: \(game.setsFound)")
            
            Spacer()
            
            Text("Undealt: \(game.undealtCards.count)")
        }
        .padding(.horizontal)
    }
    
    var bottomToolbar: some View {
        VStack {
            HStack(spacing: 0.0) {
                hintButton
                    .toolbarButton()
                    .highlight(highlight: game.setAvailable)
                    .disabled(!game.setAvailable)
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
            
            HStack {
                Text("Score: \(game.score)")
                Spacer()
                Text("Discarded: \(game.discardCards.count)")
            }
            .font(.caption)
            .padding(.horizontal)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    topToolbar
                    
                    AspectVGrid(items: game.dealtCards, aspectRatio: 2/3) { card in
                        CardView(card: card, colorBlind: $colorBlind)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                showHint = false
                                game.select(card)
                            }
                            .padding(2)
                            .border(showHint && game.setAvailable && game.firstAvailableSet.contains(card) ? Color.orange : Color.clear, width: 2.0)

                    }
                    .frame(maxHeight: geometry.size.height * 0.9)
                    
                    bottomToolbar
                }
                .disabled(showingSettings)
                .opacity(showingSettings ? 0.4 : 1.0)
                
                SettingsView(colorBlind: $colorBlind, showing: $showingSettings)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: ClassicSoloSetGame())
    }
}
