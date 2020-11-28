//
//  ViewController.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/27/20.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var editorTextView: NSTextView!
    @IBOutlet weak var outputTextView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editorTextView.delegate = self
        editorTextView.font = NSFont.monospacedSystemFont(ofSize: 14.0, weight: .regular)
        outputTextView.font = NSFont.monospacedSystemFont(ofSize: 14.0, weight: .regular)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

extension ViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        // Updates the contentString property of the Code instance with the text view's text
        (representedObject as? Code)?.contentString = editorTextView.string

    }
}
