//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Vapor

struct EntryBody: Content {
    var price: Double
    var mileage: Int
    var liters: Double?
    var dateIso: String
}

extension EntryBody {
    
    func toModel(userID: Int) -> Entry {
        return .init(
            price: self.price,
            mileage: self.mileage,
            liters: self.liters,
            dateIso: self.dateIso,
            userID: userID
        )
    }
    
}
