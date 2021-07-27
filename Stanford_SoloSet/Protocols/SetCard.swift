//
//  SetCard.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import Foundation

protocol SetCard: Identifiable, Equatable
{
    associatedtype Property1: SetProperty, CaseIterable, Hashable
    associatedtype Property2: SetProperty, CaseIterable, Hashable
    associatedtype Property3: SetProperty, CaseIterable, Hashable
    associatedtype Property4: SetProperty, CaseIterable, Hashable
    
    init(property1: Property1,
         property2: Property2,
         property3: Property3,
         property4: Property4)
    
    static func getAll() -> [Self]
    
    var isFaceUp: Bool { get set }
    
    var isSelected: Bool { get set }
    
    var isMatched: Bool { get set }
    
    var isNotMatched: Bool { get set }
    
    var property1: Property1 { get }
    var property2: Property2 { get }
    var property3: Property3 { get }
    var property4: Property4 { get }
}

protocol SetProperty {
    associatedtype Content: Equatable
}

