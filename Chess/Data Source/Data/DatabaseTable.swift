//
//  DatabaseTable.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 17/07/23.
//

import Foundation

protocol DatabaseTable {
    var name: String { get }
}

struct ProfilesTable: DatabaseTable {
    var name: String = "profiles"
    
    struct Columns {
        static let id = "id"
        static let fullname = "fullname"
        static let avatar = "avatar_url"
        static let status = "status"
        static let eloScore = "elo_score"
    }
}

struct MatchesTable: DatabaseTable {
    var name: String = "matches"
    
    struct Columns {
        static let id = "id"
        static let creatorId = "creator_id"
        static let isRequestAccepted = "is_request_accepted"
        static let winnerId = "winner_id"
        static let startedAt = "started_at"
        static let endedAt = "ended_at"
        static let note = "note"
        static let createdAt = "created_at"
    }
}

struct PlayerMatchesTable: DatabaseTable {
    var name: String = "player_matches"
    
    struct Columns {
        static let playerId = "player_id"
        static let matchId = "match_id"
    }
}
