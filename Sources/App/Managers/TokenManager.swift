//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor

struct TokenManager {
    
    static func generateToken(from req: Request, for user: User) throws -> String {
        let payload = AuthPayload(userID: "\(try user.requireID())")
        let token = try req.jwt.sign(payload)
        return token
    }
    
    static func getUserID(from req: Request) throws -> Int {
        guard let userIDString = req.storage[JWTSubjectKey.self], let userID = Int(userIDString) else {
            throw Abort(.internalServerError, reason: "No JWT found")
        }
        return userID
    }
    
}
