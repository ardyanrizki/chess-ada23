//
//  ChessApp.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import SwiftUI

@main
struct ChessApp: App {
    let sessionViewModel = SessionViewModel()
    let playerViewModel = PlayerViewModel()
    let matchViewModel = MatchViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionViewModel)
                .environmentObject(playerViewModel)
                .environmentObject(matchViewModel)
        }
    }
}
