//
//  PlayerViewModel.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import Foundation
import Supabase

class PlayerViewModel: ObservableObject {
    
    @Published var currentUser: Player?
    @Published var allPlayers: [Player] = []
    @Published var errorText: String?
    @Published var isLoading: Bool = false
    
    private let manager: SupabaseManager
    
    init(manager: SupabaseManager = SupabaseManager()) {
        self.manager = manager
        fetchCurrentUser()
    }
    
    private func getCurrentSession() async -> AppSession? {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        var result: AppSession? = nil
        if let session = await manager.getSession() {
            result = AppSession(session)
        }
        DispatchQueue.main.async {
            self.isLoading = false
        }
        return result
    }
    
    func fetchCurrentUser(completion: ((Result<Player, Error>) -> Void)? = nil) {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                guard let id = await getCurrentSession()?.uid else { throw AppError.clientErrorWithDescription("No session found.") }
                let profileDTO: Player.DTO = try await manager.fetch(for: .getUserProfile, params: RemoteProcedure.GetUserProfileParams(userId: id), single: true)
                let profile = profileDTO.toDomain()
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.currentUser = profile
                }
                completion?(.success(profile))
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorText = error.localizedDescription
                }
                completion?(.failure(error))
            }
        }
    }
    
    func fetchAllPlayers(completion: ((Result<[Player], Error>) -> Void)? = nil) {
        isLoading = true
        Task {
            do {
                let allProfilesDTO: [Player.DTO] = try await manager.fetch(for: .getAllPlayersProfile)
                let allProfiles = allProfilesDTO.map { $0.toDomain() }
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.allPlayers = allProfiles
                }
                completion?(.success(allProfiles))
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorText = error.localizedDescription
                }
                completion?(.failure(error))
            }
        }
    }
    
    func updateProfileFullname(with newFullname: String, completion: ((Result<Player, Error>) -> Void)? = nil) {
        isLoading = true
        Task {
            do {
                guard let id = await getCurrentSession()?.uid else { throw AppError.clientError(nil) }
                let editedProfileDTO: Player.DTO = try await manager.fetch(for: .updateProfileFullname, params: RemoteProcedure.UpdateProfileFullnameParams(userId: id, newFullname: newFullname), single: true)
                let editedProfile = editedProfileDTO.toDomain()
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                completion?(.success(editedProfile))
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorText = error.localizedDescription
                }
                completion?(.failure(error))
            }
        }
    }
}
