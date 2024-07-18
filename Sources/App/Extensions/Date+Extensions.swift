//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Foundation

extension Date {
    
    public func toISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
}
