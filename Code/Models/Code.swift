//
//  Code.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/28/20.
//

import Foundation

class Code: Codable {
    var contentString = ""
    
    /// Encodes and instance of Code as a JSON object
    /// - Returns: Encoded data
    func getCodeAsJSON() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    /// Decodes JSON object
    /// - Parameter data: data
    /// - Returns: boolean value
    func use(data: Data) -> Bool {
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(Code.self, from: data) else { return false }
        contentString = decoded.contentString
        return true
    }
}
