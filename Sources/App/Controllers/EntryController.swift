//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor
import Fluent

struct EntryController: RouteCollection {
    
    @Sendable
    func getEntries(req: Request) async throws -> [EntryResponse] {
        let userID = try TokenManager.getUserID(from: req)
        
        guard let user = try await User.query(on: req.db)
                .filter(\.$id == userID)
                .with(\.$entries)
                .first()
        else { throw Abort(.internalServerError, reason: "Fail to fetch user") }
        
        return user.entries.map { $0.toResponse() }
    }
    
    @Sendable
    func createEntry(req: Request) async throws -> EntryResponse {
        let body = try req.content.decode(EntryBody.self)
        let userID = try TokenManager.getUserID(from: req)
        
        let entry = body.toModel(userID: userID)
        try await entry.save(on: req.db)
        
        return entry.toResponse()
    }
    
    @Sendable
    func deleteEntry(req: Request) async throws -> HTTPStatusResponse {
        let userID = try TokenManager.getUserID(from: req)
        
        guard let entryID = req.parameters.get("entryID", as: Int.self) else {
            throw Abort(.badRequest, reason: "Invalid entry ID")
        }
        
        guard let user = try await User.query(on: req.db)
                .filter(\.$id == userID)
                .with(\.$entries)
                .first()
        else { throw Abort(.internalServerError, reason: "Fail to fetch user") }
        
        guard let entry = user.entries
            .filter({ $0.id == entryID })
            .first
        else { throw Abort(.notFound, reason: "Entry not found") }
        
        try await entry.delete(on: req.db)
        
        return .init(code: 200, reason: "Deleted !")
    }
    
}

extension EntryController {
    func boot(routes: RoutesBuilder) throws {
        let entries = routes.grouped("entry")
        
        entries.get(use: getEntries)
        entries.post(use: createEntry)
        entries.delete(":entryID", use: deleteEntry)
    }
}
