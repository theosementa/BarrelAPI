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

    @Field(key: "token")
    var token: String
    
    @Timestamp(key: "createdAt", on: .create, format: .iso8601)
    var createdAt: Date?
    
    @Children(for: \.$user)
    var entries: [Entry]

    init() { }
    
    init(
        id: Int? = nil,
        token: String,
        createdAt: Date? = nil
    ) {
        self.id = id
        self.token = token
        self.createdAt = createdAt
    }
}
