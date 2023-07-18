//
//  EditProfileScreenView.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 15/07/23.
//

import SwiftUI

struct EditProfileScreenView: View {
    
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    @State var isLoading: Bool = false
    
    @State var userFullname: String = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text("Your details")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.text)
                
                Text("Please provide your name")
                    .foregroundColor(Color.mid)
            }
            .padding(.bottom, 24)
            
            VStack(spacing: 16) {
                TextField("Enter your name", text: $userFullname)
                    .foregroundColor(Color.mid)
                    .frame(height: 54)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.horizontal, 12)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.border))
                
                Button {
                    isLoading = true
                    playerViewModel.updateProfileFullname(with: userFullname) { result in
                        sessionViewModel.updateSessionStatus {
                            isLoading = false
                        }
                    }
                } label: {
                    Color.action
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .overlay {
                            if isLoading {
                                ActivityIndicatorView(style: .medium)
                            } else {
                                Text("Continue")
                                    .foregroundColor(Color.actionText)
                            }
                        }
                }
                .disabled(userFullname.isEmpty || isLoading)
            }
            
            
        }
        .padding(.horizontal)
    }
}

struct EditProfileScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreenView()
            .environmentObject(SessionViewModel())
            .environmentObject(PlayerViewModel())
            .environmentObject(MatchViewModel())
    }
}
