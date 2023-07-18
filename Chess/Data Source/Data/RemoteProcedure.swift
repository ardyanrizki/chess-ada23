//
//  RemoteProcedure.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 17/07/23.
//

import Foundation

enum RemoteProcedure: String {
    case getUserProfile = "get_user_profile"
    case updateProfileFullname = "update_profile_fullname"
    case getAllPlayersProfile = "get_all_players_profiles"
    case createMatchRecord = "create_match_record"
    case getPlayerMatches = "get_player_matches"
    
    case createMatchRequest = "create_match_request"
    case acceptMatchRequest = "accept_match_request"
    case setMatchResult = "set_match_result"
    
    struct GetUserProfileParams: Encodable {
        let user_id: UUID
        
        init(userId: UUID) {
            user_id = userId
        }
    }

    struct CreateMatchRecordParams: Encodable {
        let win_player_id: UUID
        let lose_player_id: UUID
        
        init(winPlayerId: UUID, losePlayerId: UUID) {
            win_player_id = winPlayerId
            lose_player_id = losePlayerId
        }
    }

    struct UpdateProfileFullnameParams: Encodable {
        let user_id: UUID
        let new_fullname: String
        
        init(userId: UUID, newFullname: String) {
            user_id = userId
            new_fullname = newFullname
        }
    }
    
    struct CreateMatchRequestParams: Encodable {
        let opponent_id: UUID
        let match_note: String
        
        init(opponentId: UUID, note: String) {
            self.opponent_id = opponentId
            self.match_note = note
        }
    }
    
    struct AcceptMatchRequestParams: Encodable {
        let match_id: UUID
        
        init(matchId: UUID) {
            self.match_id = matchId
        }
    }
    
    struct SetMatchResultParams: Encodable {
        let match_id: UUID
        let winner_id: String
        
        init(matchId: UUID, winnerId: String) {
            self.match_id = matchId
            self.winner_id = winnerId
        }
    }
}
