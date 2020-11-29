//
//  WindowController.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/29/20.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
    
    @IBOutlet var codeToolBarItemTextField: NSTextField!
    let codeToolBarItemStringValue = "Code |"
    override func windowDidLoad() {
        super.windowDidLoad()
        codeToolBarItemTextField.stringValue = codeToolBarItemStringValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shouldCascadeWindows = true
    }
    
}
