//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor
import Fluent
import VaporToOpenAPI

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
            .openAPI(
                summary: "Get all entries",
                description: "Get all entries for a user",
                response: .type([EntryResponse].self),
                responseContentType: .application(.json)
            )
            .response(statusCode: 200)
            .response(statusCode: 500, description: "Internal error")
        
        entries.post(use: createEntry)
            .openAPI(
                summary: "Create entry",
                description: "Create a new entry for a user",
                body: .type(EntryBody.self),
                contentType: .application(.json),
                response: .type(EntryResponse.self),
                responseContentType: .application(.json)
            )
            .response(statusCode: 201)
            .response(statusCode: 500, description: "Internal error")
        
        entries.delete(":entryID", use: deleteEntry)
            .openAPI(
                summary: "Delete entry",
                description: "Delete an entry of a user",
                response: .type(HTTPStatusResponse.self),
                responseContentType: .application(.json)
            )
            .response(statusCode: 200)
            .response(statusCode: 400, description: "Bad Request")
            .response(statusCode: 404, description: "Not found")
            .response(statusCode: 500, description: "Internal error")
    }
}
