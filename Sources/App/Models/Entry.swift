//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Fluent
import Foundation
import Vapor

final class Entry: Model, @unchecked Sendable, Authenticatable {
    static let schema = "entries"
    
    @ID(custom: .id, generatedBy: .database)
    var id: Int?

    @Field(key: "price")
    var price: Double
    
    @Field(key: "mileage")
    var mileage: Int
    
    @Field(key: "liters")
    var liters: Double?
    
    @Field(key: "dateIso")
    var dateIso: String

    @Parent(key: "user_id")
    var user: User
    
    init() { }
    
    init(
        id: Int? = nil,
        price: Double,
        mileage: Int,
        liters: Double? = nil,
        dateIso: String,
        userID: Int
    ) {
        self.id = id
        self.price = price
        self.mileage = mileage
        self.liters = liters
        self.dateIso = dateIso
        self.$user.id = userID
    }
    
}
