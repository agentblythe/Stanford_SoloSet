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
    
//    init(property1: Card.Property1.Type,
//         property2: Card.Property2.Type,
//         property3: Card.Property3.Type,
//         property4: Card.Property4.Type) {
//        for prop1 in property1.allCases {
//            for prop2 in property2.allCases {
//                for prop3 in property3.allCases {
//                    for prop4 in property4.allCases {
//                        let card = Card(property1: prop1, property2: prop2, property3: prop3, property4: prop4)
//                        deckOfCards.append(card)
//                    }
//                }
//            }
//        }
//        deckOfCards = []
//    }
    
    init(cardGetter: () -> [Card]) {
        undealtCards = cardGetter()
        undealtCards.shuffle()
        
        discardCards = []
    }
}
