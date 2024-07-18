//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor
import Fluent

struct UserController: RouteCollection {
    
    @Sendable
    func register(req: Request) async throws -> UserResponse {
        let user = User()
        try await user.save(on: req.db)

        return .init(
            id: try user.requireID(),
            token: try TokenManager.generateToken(from: req, for: user),
            entries: []
        )
    }
    
    @Sendable
    func login(req: Request) async throws -> UserResponse {
        let userID = try TokenManager.getUserID(from: req)
        
        guard let user = try await User.query(on: req.db)
                .filter(\.$id == userID)
                .with(\.$entries)
                .first()
        else { throw Abort(.internalServerError, reason: "Fail to fetch user") }
        
        return user.toResponse()
    }
    
}

extension UserController {
    func boot(routes: RoutesBuilder) throws {
        let user = routes.grouped("user")
        let protected = user.grouped(JWTMiddleware())
        
        user.get("register", use: register)
        protected.get("login", use: login)
    }
}
