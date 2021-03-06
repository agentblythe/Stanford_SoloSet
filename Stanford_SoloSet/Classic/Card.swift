//
//  Card.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import Foundation

struct Card: SetCard {
    var isFaceUp: Bool = false
    
    var isSelected: Bool = false
    
    var isMatched: Bool = false
    
    var isNotMatched: Bool = false
    
    var isDealt: Bool = false
    
    var isDiscarded: Bool = false
    
    var isHint: Bool = false
    
    init(property1: Number, property2: Shape, property3: Shading, property4: ValidColor) {
        self.number = property1
        self.shape = property2
        self.shading = property3
        self.color = property4
    }
    
    init(number: Number, shape: Shape, shading: Shading, color: ValidColor) {
        self.number = number
        self.shape = shape
        self.shading = shading
        self.color = color
    }
    
    var id = UUID()
    
    typealias Property1 = Number
    typealias Property2 = Shape
    typealias Property3 = Shading
    typealias Property4 = ValidColor
    
    var property1: Number { get { return number; } }
    var property2: Shape { get { return shape; } }
    var property3: Shading { get { return shading; } }
    var property4: ValidColor { get { return color; } }
    
    var number: Number
    var shape: Shape
    var shading: Shading
    var color: ValidColor
    
    enum Number: Int, CaseIterable, SetProperty {
        typealias Content = Self
        
        case one = 1
        case two
        case three
    }
    
    enum Shape: CaseIterable, SetProperty {
        typealias Content = Self
        
        case diamond
        case squiggle
        case capsule
    }
    
    enum Shading: CaseIterable, SetProperty {
        typealias Content = Self
        
        case none
        case stripes
        case fill
    }
    
    enum ValidColor: String, CaseIterable, SetProperty {
        typealias Content = Self
        
        case green = "Green"
        case purple = "Purple"
        case pink = "Pink"
    }
    
    static func getAll() -> [Card] {
        var cards = [Card]()
        for number in Number.allCases {
            for shape in Shape.allCases {
                for shading in Shading.allCases {
                    for color in ValidColor.allCases {
                        let card = Card(number: number, shape: shape, shading: shading, color: color)
                        cards.append(card)
                    }
                }
            }
        }
        return cards
    }
    
    static var exampleCard: Card {
        Card(number: .two, shape: .diamond, shading: .none, color: .green)
    }
}
