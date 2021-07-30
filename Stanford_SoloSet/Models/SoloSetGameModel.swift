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
    
    var selectedIndices: [Int]? = nil
    var matchFound = false
    
    var score: Int = 0
    
    var setAvailable: Bool {
        return availableSets().count > 0
    }
    
    init(cardGetter: () -> [Card]) {
        
        undealtCards = cardGetter()
        undealtCards.shuffle()
        
        for i in 0..<12 {
            dealtCards.append(undealtCards[i])
        }
        undealtCards.removeFirst(12)
        
        discardCards = []
        
        score = 0
    }
    
    mutating func select(_ card: Card) {
        guard let chosenIndex = dealtCards.firstIndex(where: {
            $0.id == card.id
        }) else { return }
        
        // Assignment 3 logic (pre animation)
        if let indices = selectedIndices {
            if indices.count == 3 {
                if matchFound {
                    if selectedIndices!.contains(chosenIndex) {
                        selectedIndices = nil
                        replaceMatchedCards(indices: indices)
                    } else {
                        replaceMatchedCards(indices: indices)
                        selectedIndices = [Int]()
                        dealtCards[chosenIndex].isSelected = true
                        selectedIndices!.append(chosenIndex)
                    }
                    
                    matchFound = false
                } else {
                    for i in selectedIndices! {
                        dealtCards[i].isSelected = false
                        dealtCards[i].isMatched = false
                        dealtCards[i].isNotMatched = false
                    }
                    
                    selectedIndices = [Int]()
                    dealtCards[chosenIndex].isSelected = true
                    selectedIndices!.append(chosenIndex)
                    matchFound = false
                }
            } else {
                if selectedIndices!.contains(chosenIndex) {
                    dealtCards[chosenIndex].isSelected = false
                    selectedIndices!.removeAll(where: {$0 == chosenIndex})
                } else {
                    dealtCards[chosenIndex].isSelected = true
                    selectedIndices!.append(chosenIndex)
                    if selectedIndices!.count == 3 {
                        if cardsFormASet(selectedIndices!.map { dealtCards[$0] }) {
                            matchFound = true
                            for i in selectedIndices! {
                                dealtCards[i].isMatched = true
                                dealtCards[i].isNotMatched = false
                            }
                            score += 3
                        } else {
                            matchFound = false
                            for i in selectedIndices! {
                                dealtCards[i].isMatched = false
                                dealtCards[i].isNotMatched = true
                            }
                            
                            if availableSets().count > 0 {
                                score -= 1
                            }
                        }
                    }
                }
            }
        } else {
            selectedIndices = [Int]()
            selectedIndices!.append(chosenIndex)
            dealtCards[chosenIndex].isSelected = true
        }
 
        
        
//        if let indices = selectedIndices {
//            if indices.count == 3 {
//                for i in dealtCards.indices {
//                    dealtCards[i].isSelected = false
//                    dealtCards[i].isMatched = false
//                    dealtCards[i].isNotMatched = false
//                }
//                selectedIndices = nil
//            }
//        }
        
//        if selectedIndices == nil {
//            selectedIndices = [Int]()
//            selectedIndices!.append(chosenIndex)
//        } else {
//            if dealtCards[chosenIndex].isSelected {
//                selectedIndices!.removeAll(where: { $0 == chosenIndex })
//            } else {
//                selectedIndices!.append(chosenIndex)
//            }
//        }
    
//        dealtCards[chosenIndex].isSelected.toggle()
//
//        if selectedIndices!.count == 3 {
//            if setSelected(selectedIndices!.map { dealtCards[$0] }) {
//                for i in selectedIndices! {
//                    dealtCards[i].isMatched = true
//                    dealtCards[i].isNotMatched = false
//                }
//
//                replaceMatchedCards(indices: selectedIndices!)
//            } else {
//                for i in selectedIndices! {
//                    dealtCards[i].isMatched = false
//                    dealtCards[i].isNotMatched = true
//                }
//            }
//            selectedIndices = nil
//        }
    
    }
    
    private mutating func replaceMatchedCards(indices: [Int]) {
        if indices.count != 3 {
            return
        }
        
        for i in indices {
            discardCards.append(dealtCards[i])
            if undealtCards.count > 0 {
                dealtCards[i] = undealtCards.removeFirst()
            } else {
                dealtCards.remove(at: i)
            }
        }
    }
    
    func availableSets() -> [ [Card] ] {
        let cardCount = dealtCards.count
        var availableSets = [ [Card] ]()
        
        for i in 0..<cardCount {
            for j in (i+1)..<cardCount {
                for k in (j+1)..<cardCount {
                    let set = [dealtCards[i], dealtCards[j], dealtCards[k]]
                    if cardsFormASet(set) {
                        availableSets.append(set)
                    }
                }
            }
        }
        
        return availableSets
    }
    
    private func cardsFormASet(_ set: [Card]) -> Bool {
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
        if availableSets().count > 0 {
            score -= 2
        }
        
        if undealtCards.count >= 3 {
            for i in 0..<3 {
                dealtCards.append(undealtCards[i])
            }
            undealtCards.removeFirst(3)
        }
        
        for i in dealtCards.indices {
            dealtCards[i].isSelected = false
        }
        selectedIndices = nil
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
        
        selectedIndices = nil
        
        score = 0
    }
}
