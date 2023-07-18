//
//  LoginScreenView.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import SwiftUI

struct LoginScreenView: View {
    @EnvironmentObject var sessionViewModel: SessionViewModel
    
    @State var isAppleSignInLoading: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Join. Play")
                .foregroundColor(Color.text)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
            
            SignInWithAppleView(signInAction: {
                isAppleSignInLoading = true
                sessionViewModel.signInWithApple { result in
                    isAppleSignInLoading = false
                }
            }, isLoading: $isAppleSignInLoading)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
            .environmentObject(SessionViewModel())
            .environmentObject(PlayerViewModel())
            .environmentObject(MatchViewModel())
    }
}
