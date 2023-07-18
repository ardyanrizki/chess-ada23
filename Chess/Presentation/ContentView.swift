//
//  ContentView.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        ZStack {
            switch sessionViewModel.status {
            case .loggedOut:
                LoginScreenView()
            case .shouldEnterFullname:
                EditProfileScreenView()
            case .loggedIn:
                HomeScreenView()
            }
        }
        .onAppear {
            sessionViewModel.updateSessionStatus()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionViewModel())
            .environmentObject(PlayerViewModel())
            .environmentObject(MatchViewModel())
    }
}
