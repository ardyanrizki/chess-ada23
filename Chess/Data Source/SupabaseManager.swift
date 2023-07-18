//
//  SupabaseManager.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import Foundation
import Supabase
import Realtime
@_spi(Experimental) import GoTrue

final class SupabaseManager {
    
    private let config: AppConfig
    
    private let client: SupabaseClient
    
    var realtimeClient: RealtimeClient?
    
    var channel: Channel?
    
    init(config: AppConfig = AppConfig()) {
        guard let url = URL(string: config.supabaseEndpoint) else { fatalError() }
        self.config = config
        self.client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: config.supabaseAPIKey
        )
    }
    
    func getSession() async -> Session? {
        return try? await client.auth.session
    }
    
    func getTable(_ table: DatabaseTable) -> PostgrestQueryBuilder {
        client.database.from(table.name)
    }
    
    func signUpWithEmail(email: String, password: String, completion: @escaping (Result<AppSession, Error>) -> Void) {
        Task {
            do {
                let regAuthResponse = try await client.auth.signUp(email: email, password: password)
                guard let session = regAuthResponse.session else {
                    print("### No session when registering user")
                    throw AppError.clientErrorWithDescription("No session when registering user")
                }
                completion(.success(AppSession(session)))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Sign In
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<AppSession, Error>) -> Void) {
        Task {
            do {
                let session = try await client.auth.signIn(email: email, password: password)
                completion(.success(AppSession(session)))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func signInWithApple(provider: AppleSignIn, completion: @escaping (Result<AppSession, Error>) -> Void)  {
        Task {
            do {
                let appleResult = try await provider.startSignInWithAppleFlow()
                let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: appleResult.idToken, nonce: appleResult.nonce))
                completion(.success(AppSession(session)))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func signOut(completion: (() -> Void)? = nil) {
        Task {
            try await client.auth.signOut()
            completion?()
        }
    }
    
    func fetch<T: Decodable, U: Encodable>(for fn: RemoteProcedure, params: U, single: Bool = false) async throws -> T {
        let query = getQuery(for: fn, params: params, single: single)
        return try await query.execute().value
    }
    
    func fetch<T: Decodable>(for fn: RemoteProcedure, single: Bool = false) async throws -> T {
        let query = getQuery(for: fn, single: single)
        return try await query.execute().value
    }
    
    func getQuery<U: Encodable>(for fn: RemoteProcedure, params: U, single: Bool) -> PostgrestTransformBuilder {
        var query = client.database.rpc(fn: fn.rawValue, params: params)
        if single {
            query = query.single()
        }
        return query
    }
    
    func getQuery(for fn: RemoteProcedure, single: Bool) -> PostgrestTransformBuilder {
        var query = client.database.rpc(fn: fn.rawValue)
        if single {
            query = query.single()
        }
        return query
    }
    
    func createRealtimeClient() {
        realtimeClient = RealtimeClient(endPoint: config.supabaseEndpoint + "/realtime/v1", params: ["apikey": config.supabaseAPIKey])
    }
    
    func createRealtimeChannel(topic: ChannelTopic) {
        channel = realtimeClient?.channel(topic)
    }
    
    func disconnect() {
        realtimeClient?.disconnect()
    }
    
}
