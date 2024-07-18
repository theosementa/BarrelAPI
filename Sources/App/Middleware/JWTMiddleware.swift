//
//  File.swift
//  
//
//  Created by KaayZenn on 26/06/2024.
//

import Vapor
import JWT

final class JWTMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        do {
            // Extract the JWT token from the Authorization header
            guard let authHeader = request.headers.bearerAuthorization else {
                throw Abort(.unauthorized, reason: "Missing Authorization Header")
            }
            
            let payload = try request.jwt.verify(authHeader.token, as: AuthPayload.self)
            
            // Store the subject (sub) in the request storage
            request.storage[JWTSubjectKey.self] = payload.userID
            
            return next.respond(to: request)
        } catch {
            return request.eventLoop.future(error: error)
        }
    }
}

struct JWTSubjectKey: StorageKey {
    typealias Value = String
}
