//
//  Profile.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 15/07/23.
//

import Foundation

struct Player {
    let id: UUID
    let fullname: String?
    let eloScore: Float?
}

extension Player {
    struct DTO: Codable {
        let id: UUID
        let fullname: String?
        let elo_score: Float?
        
        func toDomain() -> Player {
            .init(id: id, fullname: fullname, eloScore: elo_score)
        }
    }
}
