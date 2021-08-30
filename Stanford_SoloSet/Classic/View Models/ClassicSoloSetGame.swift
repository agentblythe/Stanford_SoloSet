//
//  ClassicSoloSetGame.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import Foundation

//
// This class represents the View-Model for the Set Game
//
class ClassicSoloSetGame: ObservableObject {
    @Published private var model: SoloSetGameModel<Card>
    
    var undealtCards: Array<Card> {
        return model.undealt
    }
    
    var discardCards: Array<Card> {
        return model.discard
    }
    
    var dealtCards: Array<Card> {
        return model.inPlay
    }
    
    var setsFound: Int {
        return model.setsFound
    }
    
    var score: Int {
        return model.score
    }
    
    var setAvailable: Bool {
        return model.setAvailable
    }
    
    var firstAvailableSet: [Card]! {
        if model.setAvailable {
            return model.availableSets().first
        }
        return nil
    }
    
    var selectedCardCount: Int {
        return model.selectedIndices?.count ?? 0
    }
    
    var elapsedTime: Double {
        return model.clock.timeElapsed
    }
    
    var inPlayIndicesOfCardsToDiscard: [Int] {
        return model.inPlayIndicesOfCardsToDiscard
    }
    
    init() {
        model = SoloSetGameModel(cardGetter: Card.getAll)
    }
    
    // MARK: - Intent(s)
    func select(_ card: Card) {
        model.select(card)
    }
    
    func dealCards() {
        model.dealCards()
    }
    
    func dealCard() {
        model.dealCard()
    }
    
    func resetGame() {
        model.resetGame()
    }
    
    func markDiscardComplete() {
        model.inPlayIndicesOfCardsToDiscard.removeAll()
    }
    
    func replaceOrDiscardCard(_ card: Card) {
        model.replaceOrDiscardCard(card)
    }
    
    func discardCard(_ card: Card) {
        model.discardCard(card)
    }
    
    func dealCard(_ card: Card, to index: Int) {
        model.dealCard(card, to: index)
    }
}
