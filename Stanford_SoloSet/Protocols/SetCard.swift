//
//  SetCard.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 21/07/2021.
//

import Foundation

protocol SetCard: Identifiable
{
    associatedtype Property1: Equatable, CaseIterable
    associatedtype Property2: Equatable, CaseIterable
    associatedtype Property3: Equatable, CaseIterable
    associatedtype Property4: Equatable, CaseIterable
    
    init(property1: Property1,
         property2: Property2,
         property3: Property3,
         property4: Property4)
    
    static func getAll() -> [Self]
}
