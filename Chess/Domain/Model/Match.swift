//
//  Match.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 15/07/23.
//

import Foundation

struct Match {
    let winPlayerId: UUID
    let losePlayerId: UUID
}

extension Match {
    struct DTO: Decodable {
        let win_player_id: UUID
        let lose_player_id: UUID
        
        func toDomain() -> Match {
            .init(winPlayerId: win_player_id, losePlayerId: lose_player_id)
        }
    }
}
