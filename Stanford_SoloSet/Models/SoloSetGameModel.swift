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
    
    var clock: Clock
    
    private(set) var score: Int = 0
    
    private(set) var setsFound: Int  = 0
    
    var setAvailable: Bool {
        return availableSets().count > 0
    }
    
    init(cardGetter: () -> [Card]) {
        
        undealtCards = cardGetter()
        undealtCards.shuffle()
        
        //for i in 0..<12 {
        //    dealtCards.append(undealtCards[i])
        //}
        //undealtCards.removeFirst(12)
        
        discardCards = []
        
        score = 0
        
        clock = Clock(timeInterval: 1)
    }
    
    mutating func select(_ card: Card) {
        guard let chosenIndex = dealtCards.firstIndex(where: {
            $0.id == card.id
        }) else { return }
        
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

                        clock.start()
                    }
                    
                    matchFound = false
                } else {
                    // Check whether a set was available or not
                    if setAvailable {
                        if let set = availableSets().first {
                            for i in 0..<3 {
                                // Find the missed card in the dealt cards
                                if let found = dealtCards.firstIndex(where: { dealtCard in
                                    dealtCard.id == set[i].id
                                }) {
                                    // Move it to the discard pile
                                    discardCards.append(dealtCards[found])
                                    
                                    // Replace it with a new card
                                    if undealtCards.count > 1 {
                                        dealtCards[found] = undealtCards.removeFirst()
                                    }
                                }
                            }
                        }
                    }
                    
                    // Clear any selections and reset the matched/not matched flags
                    // for the next round
                    for i in selectedIndices! {
                        dealtCards[i].isSelected = false
                        dealtCards[i].isMatched = false
                        dealtCards[i].isNotMatched = false
                    }
                    
                    // Reset the selected indices as none are now selected
                    selectedIndices = [Int]()
                    
                    // Process the selection
                    dealtCards[chosenIndex].isSelected = true
                    selectedIndices!.append(chosenIndex)
                    matchFound = false
                    
                    clock.start()
                }
            } else {
                if selectedIndices!.contains(chosenIndex) {
                    dealtCards[chosenIndex].isSelected = false
                    selectedIndices!.removeAll(where: {$0 == chosenIndex})
                    
                    if selectedIndices!.count == 0 {
                        selectedIndices = nil
                        clock.stop()
                    }
                } else {
                    dealtCards[chosenIndex].isSelected = true
                    selectedIndices!.append(chosenIndex)
                    if selectedIndices!.count == 3 {
                        clock.stop()
                        
                        if cardsFormASet(selectedIndices!.map { dealtCards[$0] }) {
                            // The selected cards form a set
                            matchFound = true
                            for i in selectedIndices! {
                                dealtCards[i].isMatched = true
                                dealtCards[i].isNotMatched = false
                            }
                            
                            score += calculateScoreForElapsedTime(clock.timeElapsed)
                            
                            setsFound += 1
                        } else {
                            // The selected cards do not form a set
                            matchFound = false
                            for i in selectedIndices! {
                                dealtCards[i].isMatched = false
                                dealtCards[i].isNotMatched = true
                            }
                            
                            // Check whether there was a set available to be chosen
                            // that the player has missed
                            let availableSets = availableSets()
                            if availableSets.count > 0 {
                                // Reduce the score because the player missed a valid set
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
            
            clock.start()
        }
    }
    
    private func calculateScoreForElapsedTime(_ elapsedTime : Int) -> Int {
        let matchScore = 10 - elapsedTime
        if matchScore <= 0 {
            return 1
        }
        return matchScore
    }
    
    private mutating func replaceMatchedCards(indices: [Int]) {
        if indices.count != 3 {
            return
        }
        
        for i in indices {
            dealtCards[i].isSelected = false
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
    
    mutating func dealInitialCards() {
        dealtCards.removeAll()
        for _ in 0..<12 {
            dealtCards.append(undealtCards.removeFirst())
        }
    }
    
    mutating func dealCards() {
        if dealtCards.count == 0 {
            dealInitialCards()
        } else {
            if availableSets().count > 0 {
                score -= 2
            }
            
            for _ in 0..<3 {
                if undealtCards.count >= 1 {
                    dealtCards.append(undealtCards.removeFirst())
                }
            }
            
            for i in dealtCards.indices {
                dealtCards[i].isSelected = false
            }
            selectedIndices = nil
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
        
        selectedIndices = nil
        
        score = 0
    }
}
