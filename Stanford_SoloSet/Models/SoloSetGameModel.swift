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
    
    var selectedIndices: [Int]?
    
    init(cardGetter: () -> [Card]) {
        
        undealtCards = cardGetter()
        undealtCards.shuffle()
        
        for i in 0..<3 {
            dealtCards.append(undealtCards[i])
        }
        undealtCards.removeFirst(3)
        
        discardCards = []
    }
    
    mutating func select(_ card: Card) {
        guard let chosenIndex = dealtCards.firstIndex(where: {
            $0.id == card.id
        }) else { return }
        
        if let indices = selectedIndices {
            if indices.count == 3 {
                for i in dealtCards.indices {
                    dealtCards[i].isSelected = false
                    dealtCards[i].isMatched = false
                    dealtCards[i].isNotMatched = false
                }
                selectedIndices = nil
            }
        }
        
        dealtCards[chosenIndex].isSelected.toggle()
    
        if dealtCards.count(where: { $0.isSelected }) == 0 {
            selectedIndices = nil
        } else {
            if selectedIndices == nil {
                selectedIndices = [Int]()
            }
            selectedIndices!.append(chosenIndex)
            
            if selectedIndices!.count == 3 {
                if setSelected(selectedIndices!.map { dealtCards[$0] }) {
                    for i in selectedIndices! {
                        dealtCards[i].isMatched = true
                        dealtCards[i].isNotMatched = false
                    }
                } else {
                    for i in selectedIndices! {
                        dealtCards[i].isMatched = false
                        dealtCards[i].isNotMatched = true
                    }
                }
            }
        }
    }
    
    func setSelected(_ set: [Card]) -> Bool {
        var property1Set = Set<Card.Property1>()
        var property2Set = Set<Card.Property2>()
        var property3Set = Set<Card.Property3>()
        var property4Set = Set<Card.Property4>()
        
        for card in set {
            property1Set.insert(card.property1)
            property2Set.insert(card.property2)
            property3Set.insert(card.property3)
            property4Set.insert(card.property4)
        }
        
        if property1Set.count == 2 ||
            property2Set.count == 2 ||
            property3Set.count == 2 ||
            property4Set.count == 2 {
            return false
        }
        
        return true
    }
    
    mutating func dealMoreCards() {
        if undealtCards.count >= 3 {
            for i in 0..<3 {
                dealtCards.append(undealtCards[i])
            }
            undealtCards.removeFirst(3)
        }
    }
    
    mutating func resetGame() {
        undealtCards.removeAll()
        dealtCards.removeAll()
        discardCards.removeAll()
        
        undealtCards = Card.getAll()
        undealtCards.shuffle()
        
        for i in 0..<12 {
            dealtCards.append(undealtCards[i])
        }
        undealtCards.removeFirst(12)
        
        discardCards = []
    }
}
