//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Foundation
import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .field("id", .int, .identifier(auto: true))
            .field("createdAt", .string, .required, .sql(.default(Date().toISO8601String())))
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("users").delete()
    }
}
