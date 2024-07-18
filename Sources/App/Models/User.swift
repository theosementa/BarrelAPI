//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor
import Fluent

final class User: Model, @unchecked Sendable, Authenticatable {
    static let schema = "users"
    
    @ID(custom: .id, generatedBy: .database)
    var id: Int?
    
    @Timestamp(key: "createdAt", on: .create, format: .iso8601)
    var createdAt: Date?
    
    @Children(for: \.$user)
    var entries: [Entry]

    init() { }
    
    init(
        id: Int? = nil,
        createdAt: Date? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
    }
}

extension User {
    
    func toResponse() -> UserResponse {
        return .init(
            id: self.id ?? 0,
            entries: self.entries.map { $0.toResponse() }
        )
    }
}
