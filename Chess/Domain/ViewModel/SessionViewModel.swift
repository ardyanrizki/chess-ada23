//
//  SessionViewModel.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import Foundation
import Supabase

enum SessionStatus {
    case loggedOut
    case shouldEnterFullname
    case loggedIn
}

class SessionViewModel: ObservableObject {
    
    @Published var status: SessionStatus = .loggedOut
    @Published var isLoading: Bool = false
    
    private let manager: SupabaseManager
    
    init(manager: SupabaseManager = SupabaseManager()) {
        self.manager = manager
    }
    
    private func getCurrentSession() async -> AppSession? {
        guard let session = await manager.getSession() else { return nil }
        return AppSession(session)
    }
    
    private func getCurrentUser() async -> Player? {
        do {
            let session = await getCurrentSession()
            guard let id = session?.uid else { return nil }
            let playerDTO: Player.DTO = try await manager.fetch(for: .getUserProfile, params: RemoteProcedure.GetUserProfileParams(userId: id), single: true)
            return playerDTO.toDomain()
        } catch {
            print("### \(error.localizedDescription)")
            return nil
        }
    }
    
    private func isFormValid(email: String, password: String) -> Bool {
        guard email.isValidEmail(), password.count > 7 else {
            return false
        }
        return true
    }
    
    func updateSessionStatus(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        Task {
            if let user = await getCurrentUser() {
                DispatchQueue.main.async {
                    self.status = user.fullname == nil ? .shouldEnterFullname : .loggedIn
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.status = .loggedOut
                    self.isLoading = false
                }
            }
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
    @MainActor
    func signInWithApple(completion: ((Result<AppSession, Error>) -> Void)? = nil) {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        manager.signInWithApple(provider: AppleSignIn()) { result in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            self.updateSessionStatus()
            completion?(result)
        }
    }
    
    func signUpWithEmail(email: String, password: String, completion: ((Result<AppSession, Error>) -> Void)? = nil) {
        Task {
            if isFormValid(email: email, password: password) {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                manager.signUpWithEmail(email: email, password: password) { result in
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    self.updateSessionStatus()
                    completion?(result)
                }
            } else {
                print("### Sign up form is invalid")
                completion?(.failure(AppError.clientErrorWithDescription("Sign up form is invalid")))
            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: ((Result<AppSession, Error>) -> Void)? = nil) {
        if isFormValid(email: email, password: password) {
            DispatchQueue.main.async {
                self.isLoading = true
            }
            manager.signInWithEmail(email: email, password: password) { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                self.updateSessionStatus()
                completion?(result)
            }
        } else {
            print("### Sign in form is invalid")
            completion?(.failure(AppError.clientErrorWithDescription("Sign in form is invalid")))
        }
    }
    
    func signOut() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        manager.signOut {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            self.updateSessionStatus()
        }
    }
}

extension String {
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)

    }
}
