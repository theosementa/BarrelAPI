//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor

struct UserResponse: Content {
    var id: Int
    var token: String
    var entries: [EntryResponse]
}
