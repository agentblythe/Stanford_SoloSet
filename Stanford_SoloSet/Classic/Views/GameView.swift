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
    
    @Namespace private var dealingNamespace
    
    @State var showHint = false
    
    @State var colorBlind = false
    
    @State var showingSettings = false
    
//    private func isUndealt(_ card: Card) -> Bool {
//        return !game.dealtCards.contains(card)
//    }
    
    private func dealInitialCards() {
        let newCards = game.undealtCards.prefix(12)
        for card in newCards {
            withAnimation(dealAnimation(for: card, in: newCards)) {
                game.dealCard()
            }
        }
    }
    
    private func dealCards() {
        let newCards = game.undealtCards.prefix(3)
        for card in newCards {
            withAnimation(dealAnimation(for: card, in: newCards)) {
                game.dealCard()
            }
        }
    }
    
    private func discardCards() {
        let inPlayIndicesOfCardsToDiscard = game.inPlayIndicesOfCardsToDiscard
        if inPlayIndicesOfCardsToDiscard.count > 0 {
            inPlayIndicesOfCardsToDiscard.forEach { i in
                var card = game.dealtCards[i]
                withAnimation(discardAnimation(for: card)) {
                    game.discardCard(card)
                }
            }
        }
    }
    
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
            Text("Sets Found: \(game.setsFound)\nScore: \(game.score) Dealt: \(game.dealtCards.count)")
                .multilineTextAlignment(.leading)
            Spacer()
            hintButton
                .foregroundColor(.orange)
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

                    HStack(alignment: .bottom) {
                        undealtDeckBody
                            .padding(.horizontal)
                            .onTapGesture {
                                game.dealCards()
                            }
                        Spacer()
                        restartButton
                        Spacer()
                        
                        discardPileBody
                            .padding(.horizontal)
                    }
                }
            }
            .disabled(showingSettings)
            .opacity(showingSettings ? 0.4 : 1.0)
            .onAppear(perform: {
                dealInitialCards()
            })
            
            SettingsView(colorBlind: $colorBlind, showing: $showingSettings)
        }
    }
    
    private func dealAnimation(for card: Card, in newCards: ArraySlice<Card>) -> Animation {
        var delay = 0.0
        if let index = newCards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(newCards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func discardAnimation(for card: Card) -> Animation {
        return Animation.easeInOut
    }
    
//    private func zIndex(of card: Card) -> Double {
//        // Higher Z Indices are nearer the top
//        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
//    }
    
    var gameBody: some View {
        AspectVGrid(items: game.dealtCards, aspectRatio: DrawingConstants.aspectRatio, spacing: 5) { card in
            CardView(card: card, colorBlind: $colorBlind)
                .contentShape(Rectangle())
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
//                .transition(.asymmetric(insertion: .identity, removal: .scale))
//                .zIndex(zIndex(of: card))
                .border(showHint && game.setAvailable && game.firstAvailableSet.contains(card) ? Color.orange : Color.clear, width: 5.0)
                .onTapGesture {
                    showHint = false
                    game.select(card)
                }
        }
    }
    
    var undealtDeckBody: some View {
        VStack {
            ZStack {
                ForEach(game.undealtCards) { card in
                    CardView(card: card, colorBlind: $colorBlind)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
//                        .transition(.asymmetric(insertion: .opacity, removal: .identity))
//                        .zIndex(zIndex(of: card))
                }
            }
            .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight, alignment: .center)
            .onTapGesture {
                dealCards()
            }
            
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
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
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
        Group {
            GameView(game: ClassicSoloSetGame())
        }
    }
}
