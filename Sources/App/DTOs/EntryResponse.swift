//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor

struct EntryResponse: Content {
    var id: Int?
    var price: Double
    var mileage: Int
    var liters: Double?
    var dateIso: String
}
