//
//  Code.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/28/20.
//

import Foundation

class Code: Codable {
    var contentString = ""

    /// Creates a string object from data
    /// - Parameter data: data
    /// - Returns: boolean value if data is decoded
    func use(data: Data) -> Bool {
        // Try to create a String object using it.
        guard let text = String(data: data, encoding: .utf8) else { return false }
        
        // Data was converted to a string successfully!
        contentString = text
        return true
    }

    /// Gets the text of the Code object
    /// - Returns: Data of contentString, encoded using utf8
    func getCodeText() -> Data? {
        return contentString.data(using: .utf8)
    }
}
