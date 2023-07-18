//
//  SignInWithAppleView.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 17/07/23.
//

import SwiftUI

struct SignInWithAppleView: View {
    
    let signInAction: () -> Void
    @Binding var isLoading: Bool
    
    var body: some View {
        Button(action: signInAction) {
            Color.action
                .cornerRadius(12)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .overlay {
                    if isLoading {
                        ActivityIndicatorView(style: .medium)
                    } else {
                        HStack {
                            Image(systemName: "apple.logo")
                            Text("Sign in with Apple")
                        }
                        .foregroundColor(Color.actionText)
                    }
                }
        }
        .disabled(isLoading)
    }
}
