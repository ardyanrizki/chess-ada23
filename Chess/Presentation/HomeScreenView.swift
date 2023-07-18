//
//  HomeScreenView.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 17/07/23.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "apple.logo")
                    .imageScale(.large)
                    .padding(.bottom, 4)
                Text("Hello, \(playerViewModel.currentUser?.fullname ?? "world")!")
            }
            .padding(.bottom, 40)
            
            Button {
                sessionViewModel.signOut()
            } label: {
                Text("Sign out")
                    .foregroundColor(.action)
            }
        }
        .foregroundColor(Color.text)
        .padding()
        .onAppear {
            playerViewModel.fetchCurrentUser()
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(SessionViewModel())
            .environmentObject(PlayerViewModel())
            .environmentObject(MatchViewModel())
    }
}
