//
//  SoloSetGame.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 19/07/2021.
//

import Foundation

struct SoloSetGameModel<Card: SetCard> {
    
    // All cards that are as yet, undealt
    private(set) var undealt: Array<Card> = []
    
    // All cards that have been discarded
    private(set) var discard: Array<Card> = []
    
    // All cards that are in-play and active
    private(set) var inPlay: Array<Card> = []
    
    var selectedIndices: [Int]? = nil
    
    var matchFound = false
    
    var inPlayIndicesOfCardsToDiscard: [Int] = []
    
    var clock: Clock
    
    private(set) var score: Int = 0
    
    private(set) var setsFound: Int  = 0
    
    var setAvailable: Bool {
        return availableSets().count > 0
    }
    
    init(cardGetter: () -> [Card]) {
        
        undealt = cardGetter()
        undealt.shuffle()
        
        inPlay = []
        
        discard = []

        score = 0
        
        clock = Clock(timeInterval: 1)
    }
    
    mutating func select(_ card: Card) {
        //print("debug::select()")
        guard let chosenIndex = inPlay.firstIndex(where: {
            $0.id == card.id
        }) else { return }
        
        //print("debug::\(chosenIndex)")
        
        // Get the indexes of the selected cards
        if let indices = selectedIndices {
            // If there are three selected
            if indices.count == 3 {
                // Is the selection a match?
                if matchFound {
                    //print("debug::matchFound")
                    // If the selected indices does not contain the selected index
                    if selectedIndices!.contains(chosenIndex) {
                        // Unselect all cards
                        selectedIndices = nil
                        // Replace them with new ones
                        //replaceMatchedCards(at: indices)
                    } else {
                        // The selected indices does not contain the selected index
                        //replaceMatchedCards(at: indices)
                        
                        selectedIndices = [Int]()
                        inPlay[chosenIndex].isSelected = true
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
                                if let found = inPlay.firstIndex(where: { dealtCard in
                                    dealtCard.id == set[i].id
                                }) {
                                    inPlay[found].isSelected = false
                                    inPlay[found].isMatched = false
                                    inPlay[found].isNotMatched = false
                                    discard.append(inPlay[found])
                                    
                                    if undealt.count > 1 {
                                        inPlay[found] = undealt.first!
                                    }
                                }
                            }
                        }
                    }
                    
                    // Clear any selections and reset the matched/not matched flags
                    // for the next round
                    for i in selectedIndices! {
                        inPlay[i].isSelected = false
                        inPlay[i].isMatched = false
                        inPlay[i].isNotMatched = false
                    }
                    
                    // Reset the selected indices as none are now selected
                    selectedIndices = [Int]()
                    
                    // Process the selection
                    inPlay[chosenIndex].isSelected = true
                    selectedIndices!.append(chosenIndex)
                    matchFound = false
                    
                    clock.start()
                }
            } else {
                if selectedIndices!.contains(chosenIndex) {
                    inPlay[chosenIndex].isSelected = false
                    selectedIndices!.removeAll(where: {$0 == chosenIndex})
                    
                    if selectedIndices!.count == 0 {
                        selectedIndices = nil
                        clock.stop()
                    }
                } else {
                    inPlay[chosenIndex].isSelected = true
                    selectedIndices!.append(chosenIndex)
                    if selectedIndices!.count == 3 {
                        clock.stop()
                        
                        if cardsFormASet(selectedIndices!.map { inPlay[$0] }) {
                            // The selected cards form a set
                            matchFound = true
                            
                            inPlayIndicesOfCardsToDiscard = selectedIndices!
                            
                            for i in selectedIndices! {
                                inPlay[i].isMatched = true
                                inPlay[i].isNotMatched = false
                            }
                            
                            score += calculateScoreForElapsedTime(clock.timeElapsed)
                            
                            setsFound += 1
                            
                            
                        } else {
                            // The selected cards do not form a set
                            matchFound = false
                            for i in selectedIndices! {
                                inPlay[i].isMatched = false
                                inPlay[i].isNotMatched = true
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
            inPlay[chosenIndex].isSelected = true
            
            clock.start()
        }
        
        //print("debug::end()")
    }
    
    private func calculateScoreForElapsedTime(_ elapsedTime : Double) -> Int {
        let matchScore = 10 - elapsedTime
        if matchScore <= 0 {
            return 1
        }
        return Int(matchScore)
    }
    
    func availableSets() -> [ [Card] ] {
        let cardCount = inPlay.count
        var availableSets = [ [Card] ]()
        
        for i in 0..<cardCount {
            for j in (i+1)..<cardCount {
                for k in (j+1)..<cardCount {
                    let set = [inPlay[i], inPlay[j], inPlay[k]]
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
    
    mutating func dealCard() {
        dealCards(1)
    }
    
    mutating func dealCards(_ numberOfCards: Int = 3) {
        for _ in 0..<numberOfCards {
            if undealt.count > 1 {
                inPlay.append(undealt.first!)
                undealt.removeFirst()
                
                inPlay[inPlay.count - 1].isFaceUp = true
            }
        }
    }
    
    mutating func replaceOrDiscardCard(_ card: Card) {
        if let index = inPlay.firstIndex(of: card) {
            inPlay[index].isDealt = false
            inPlay[index].isSelected = false
            inPlay[index].isMatched = false
            inPlay[index].isNotMatched = false
            inPlay[index].isDiscarded = true
            
            let card = inPlay[index]
            
            if undealt.count > 1 {
                discard.append(card)
                
                inPlay[index] = undealt.removeFirst()
                inPlay[index].isFaceUp = true
            } else {
                discard.append(card)
                
                inPlay.remove(at: index)
            }
        }
    }
    
    mutating func discardCard(_ card: Card) {
        if let index = inPlay.firstIndex(of: card) {
            
            inPlay[index].isDealt = false
            inPlay[index].isSelected = false
            inPlay[index].isMatched = false
            inPlay[index].isNotMatched = false
            inPlay[index].isDiscarded = true
            
            discard.append(inPlay[index])
            inPlay.remove(at: index)
        }
    }
    
    mutating func dealCard(_ card: Card, to index: Int) {
        inPlay.insert(card, at: index)
        undealt.removeFirst()
        
        inPlay[index].isDealt = true
        inPlay[index].isFaceUp = true
    }
    
    mutating func resetGame() {
        undealt = Card.getAll()
        undealt.shuffle()
        
        inPlay = []
        discard = []
        
        selectedIndices = nil
        
        score = 0
    }
}
