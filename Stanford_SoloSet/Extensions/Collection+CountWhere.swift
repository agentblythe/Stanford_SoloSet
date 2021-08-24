//
//  Collection+.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 26/07/2021.
//

import Foundation

extension Collection {
    func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}

