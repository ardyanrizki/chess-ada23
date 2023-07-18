//
//  MatchViewModel.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import Foundation
import Supabase

class MatchViewModel: ObservableObject {
    
    private let manager: SupabaseManager
    
    init(manager: SupabaseManager = SupabaseManager()) {
        self.manager = manager
    }
    
    func createMatchRecord(winPlayerId: UUID, losePlayerId: UUID, completion: @escaping (Result<Match, Error>) -> Void) {
        Task {
            do {
                let matchDTO: Match.DTO = try await manager.fetch(for: .createMatchRecord, params: RemoteProcedure.CreateMatchRecordParams(winPlayerId: winPlayerId, losePlayerId: losePlayerId))
                completion(.success(matchDTO.toDomain()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
