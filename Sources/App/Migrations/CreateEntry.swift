//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Foundation
import Fluent

struct CreateEntry: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("entries")
            .field("id", .int, .identifier(auto: true))
            .field("price", .double, .required)
            .field("mileage", .int, .required)
            .field("liters", .double)
            .field("dateIso", .string, .required)
            .field("user_id", .int, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("entries").delete()
    }
}
