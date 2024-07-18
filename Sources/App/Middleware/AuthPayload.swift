//
//  File.swift
//  
//
//  Created by KaayZenn on 26/06/2024.
//

import JWT

struct AuthPayload: JWTPayload {
    
    enum CodingKeys: String, CodingKey {
        case userID = "uid"
    }

    var userID: String
    
    func verify(using signer: JWTKit.JWTSigner) throws {
        
    }
    
}
