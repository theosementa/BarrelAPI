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
        let token = UUID().uuidString
        let user = User(token: token)
        try await user.save(on: req.db)
        
        guard let reloadedUser = try await User.query(on: req.db)
                .filter(\.$token == token)
                .first()
            else { throw Abort(.internalServerError, reason: "Failed to reload user after saving") }
        
        return reloadedUser.toResponse()
    }
    
    @Sendable
    func login(req: Request) async throws -> UserResponse {
        let body = try req.content.decode(UserLoginBody.self)
        
        guard let user = try await User.query(on: req.db)
            .filter(\.$token == body.token)
            .first()
        else { throw Abort(.internalServerError, reason: "Fail to fetch user") }
        
        return user.toResponse()
    }
    
}

extension UserController {
    func boot(routes: RoutesBuilder) throws {
        let user = routes.grouped("user")
        
        user.get("register", use: register)
        user.post("login", use: login)
    }
}
