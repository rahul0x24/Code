//
//  REPL.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/28/20.
//

import Foundation

final class REPL {
    private let process = Process()
    private let stdInput = Pipe()
    
    init() {
        process.launchPath = "/usr/bin/swift"
        process.standardInput = stdInput.fileHandleForReading
        process.launch()
    }
    
    func execute(_ code: String) {
        stdInput.fileHandleForWriting.write(code.data(using: .utf8)!)
    }
}
