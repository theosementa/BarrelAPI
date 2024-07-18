//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor
import Fluent
import VaporToOpenAPI

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
            .openAPI(
                summary: "New user",
                description: "Register a new user",
                response: .type(UserResponse.self),
                responseContentType: .application(.json)
            )
            .response(statusCode: 200)
        
        protected.get("login", use: login)
            .openAPI(
                summary: "Login",
                description: "Login a user | JWT is needed !",
                response: .type(UserResponse.self),
                responseContentType: .application(.json)
            )
            .response(statusCode: 200)
            .response(statusCode: 500, description: "Internal error")
    }
}
