//
//  AppConfig.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import Foundation
import SwiftUI

class AppConfig {
    let supabaseAPIKey: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJic3NwZW11ZWxxdXlscWhtaXl1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODkyNDY2MzIsImV4cCI6MjAwNDgyMjYzMn0.E7azmUC4qABf0gwxumeh-zD1qr56q8O3PfNcJ-E2tc0"
    let supabaseEndpoint: String = "https://rbsspemuelquylqhmiyu.supabase.co"
}

enum AppError: Error, LocalizedError {
    case clientError(Error?)
    case clientErrorWithDescription(String)
    
    var errorDescription: String {
        switch self {
        case .clientError(let err):
            return NSLocalizedString(
                err != nil ? err?.localizedDescription ?? "Client error." : "Client error.",
                comment: "Failed to get data."
            )
        case .clientErrorWithDescription(let string):
            return string
        }
    }
}
