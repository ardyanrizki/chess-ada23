//
//  Session.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 14/07/23.
//

import Foundation
import Supabase

struct AppSession {
    let uid: UUID
    let email: String?
    
    init(_ session: Session) {
        uid = session.user.id
        email = session.user.email
    }
}
