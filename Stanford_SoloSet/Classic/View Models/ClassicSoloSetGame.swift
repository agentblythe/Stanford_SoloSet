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
    
//    init() {
//        model = SoloSetGameModel<Card>(property1: Card.Number.self,
//                                       property2: Card.Shape.self,
//                                       property3: Card.Shading.self,
//                                       property4: Card.ValidColor.self)
//    }
    
    init() {
        model = SoloSetGameModel(cardGetter: Card.getAll)
    }
}
