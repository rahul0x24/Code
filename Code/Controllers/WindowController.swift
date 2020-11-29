//
//  WindowController.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/29/20.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
    
    @IBOutlet var codeToolBarItemTextField: NSTextField!
    var udObservation: NSKeyValueObservation?

    override func windowDidLoad() {
        super.windowDidLoad()

        codeToolBarItemTextField.stringValue = "test"
        let ud = UserDefaults.standard

        codeToolBarItemTextField.stringValue = String(ud.string(forKey: "Label")!)
        udObservation = ud.observe(\.Label, options: .new, changeHandler: { (ud, change) in
            if let newValue = change.newValue {
                self.codeToolBarItemTextField.stringValue = String(newValue)
            }
        })
        codeToolBarItemTextField.stringValue = UserDefaults.standard.string(forKey: "Label") ?? "test"

        ud.setValue("Code |", forKey: "Label")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shouldCascadeWindows = true
    }
    
}
