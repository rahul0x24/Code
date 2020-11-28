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
    private let stdError = Pipe()
    private let stdOutput = Pipe()
    
    private var stdOutputtoken: Any?
    private var stdErrorToken: Any?
    
    init(onStdOut: @escaping (String) -> (), onStdErr: @escaping (String) -> ()) {
        process.launchPath = "/usr/bin/swift"
        process.standardInput = stdInput.fileHandleForReading
        process.standardOutput = stdOutput.fileHandleForWriting
        process.standardError = stdError.fileHandleForWriting

        stdOutputtoken = NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: stdOutput.fileHandleForReading, queue: nil) { [unowned self](code) in
            let data = self.stdOutput.fileHandleForReading.availableData
            let string = String(data: data, encoding: .utf8)!
            onStdOut(string)
            self.stdOutput.fileHandleForReading.waitForDataInBackgroundAndNotify()
        }
        
        stdErrorToken = NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: stdError.fileHandleForReading, queue: nil) { [unowned self](code) in
            let data = self.stdError.fileHandleForReading.availableData
            let string = String(data: data, encoding: .utf8)!
            onStdErr(string)
            self.stdError.fileHandleForReading.waitForDataInBackgroundAndNotify()
        }
        
        process.launch()
        stdOutput.fileHandleForReading.waitForDataInBackgroundAndNotify()
        stdError.fileHandleForReading.waitForDataInBackgroundAndNotify()
    }
    
    func execute(_ code: String) {
        stdInput.fileHandleForWriting.write(code.data(using: .utf8)!)
    }
}
