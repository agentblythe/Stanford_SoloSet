//
//  ClassicSoloSetGame.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import Foundation

class ClassicSoloSetGame: ObservableObject {
    @Published private var model: SoloSetGameModel<Card>
    
    var undealtCards: Array<Card> {
        return model.undealtCards
    }
    
    var discardCards: Array<Card> {
        return model.discardCards
    }
    
    var dealtCards: Array<Card> {
        return model.dealtCards
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
    
    init() {
        model = SoloSetGameModel(cardGetter: Card.getAll)
    }
    
    // MARK: - Intent(s)
    func select(_ card: Card) {
        model.select(card)
    }
    
    func dealMoreCards() {
        model.dealMoreCards()
    }
    
    func resetGame() {
        model.resetGame()
    }
}
