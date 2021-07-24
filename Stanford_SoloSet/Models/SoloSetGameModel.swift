//
//  SoloSetGame.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 19/07/2021.
//

import Foundation

struct SoloSetGameModel<Card: SetCard> {
    private(set) var undealtCards: Array<Card> = []
    private(set) var discardCards: Array<Card> = []
    private(set) var dealtCards: Array<Card> = []
    
    init(cardGetter: () -> [Card]) {
        undealtCards = cardGetter()
        undealtCards.shuffle()
        
        for i in 0..<12 {
            dealtCards.append(undealtCards[i])
        }
        undealtCards.removeFirst(12)
        
        discardCards = []
    }
}
