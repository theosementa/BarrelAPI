//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor

struct HTTPStatusResponse: Content {
    var code: Int
    var reason: String
}
