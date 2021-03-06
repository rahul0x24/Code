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
    private let userDefaults = UserDefaults.standard
    private let proceessIsRunning = Pipe()

    private var stdOutputtoken: Any?
    private var stdErrorToken: Any?
    
    init(onStdOut: @escaping (String) -> (), onStdErr: @escaping (String) -> ()) {
        process.launchPath = "/usr/bin/swift"
        process.standardInput = stdInput.fileHandleForReading
        process.standardOutput = stdOutput.fileHandleForWriting
        process.standardError = stdError.fileHandleForWriting
        
        var bufferedStdOutData = Data()
        stdOutputtoken = NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: stdOutput.fileHandleForReading, queue: nil) { [unowned self](code) in
            bufferedStdOutData.append(self.stdOutput.fileHandleForReading.availableData)

            if let string = String(data: bufferedStdOutData, encoding: .utf8) , string.last?.isNewline == true {
                onStdOut(string)
                bufferedStdOutData.removeAll()
            }
            self.stdOutput.fileHandleForReading.waitForDataInBackgroundAndNotify()
        }
        
        stdErrorToken = NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: stdError.fileHandleForReading, queue: nil) { [unowned self](code) in
            let data = self.stdError.fileHandleForReading.availableData
            let string = String(data: data, encoding: .utf8)!
            userDefaults.setValue("Code | Failure at \(formatTime())", forKey: "Label")
            onStdErr(string)
            self.stdError.fileHandleForReading.waitForDataInBackgroundAndNotify()
        }
        process.launch()
        stdOutput.fileHandleForReading.waitForDataInBackgroundAndNotify()
        stdError.fileHandleForReading.waitForDataInBackgroundAndNotify()
    }
    
    func execute(_ code: String) {
        userDefaults.setValue("Code | Success at \(formatTime())", forKey: "Label")
        stdInput.fileHandleForWriting.write(code.data(using: .utf8)!)
    }
    
    func formatTime() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        
        let today = formatter.string(from: currentDateTime)
        return today
    }
}
