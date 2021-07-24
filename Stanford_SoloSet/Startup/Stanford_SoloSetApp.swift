//
//  Stanford_SoloSetApp.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 19/07/2021.
//

import SwiftUI

@main
struct Stanford_SoloSetApp: App {
    private let game = ClassicSoloSetGame()
    
    var body: some Scene {
        WindowGroup {
            GameView(game: game)
        }
    }
}
