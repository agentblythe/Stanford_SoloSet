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
    
    var newGameButton: some View {
        Button(action: {
            game.resetGame()
        }, label: {
            Text("New Game")
        })
    }
    
    var topToolbar: some View {
        HStack {
            Text("Sets Found: \(game.setsFound)\nScore: \(game.score)")
                .multilineTextAlignment(.leading)
            Spacer()
            hintButton
                .highlight(highlight: game.setAvailable)
                .disabled(!game.setAvailable)
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack {
                    topToolbar
                    
                    gameBody
                    
                    restartButton
                }
                
                HStack {
                    undealtDeckBody
                        .padding(.horizontal)
                        .onTapGesture {
                            game.dealCards()
                        }
                    
                    Spacer()
                    
                    discardPileBody
                        .padding(.horizontal)
                }
            }
            .disabled(showingSettings)
            .opacity(showingSettings ? 0.4 : 1.0)
            
            SettingsView(colorBlind: $colorBlind, showing: $showingSettings)
        }
    }
    
    var gameBody: some View {
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
    }
    
    var undealtDeckBody: some View {
        VStack {
            ZStack {
                ForEach(game.undealtCards) { card in
                    CardView(card: card, colorBlind: $colorBlind, isFaceUp: false)
                }
            }
            .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight, alignment: .center)
            
            Text("Undealt\n\(game.undealtCards.count)")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
    
    var discardPileBody: some View {
        VStack {
            ZStack {
                ForEach(game.discardCards) { card in
                    CardView(card: card, colorBlind: $colorBlind, isFaceUp: true)
                }
            }
            .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight, alignment: .center)
            .border(game.discardCards.count == 0 ? Color.black : Color.clear)
            
            Text("Discarded\n\(game.discardCards.count)")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
    
    var restartButton: some View {
        Button(action: {
            game.resetGame()
        }, label: {
            Text("Restart\nGame")
                .multilineTextAlignment(.center)
        })
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: ClassicSoloSetGame())
    }
}
