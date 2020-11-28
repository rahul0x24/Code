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
        // Do any additional setup after loading the view.
        editorTextView.font = NSFont.monospacedSystemFont(ofSize: 14.0, weight: .regular)
        outputTextView.font = NSFont.monospacedSystemFont(ofSize: 14.0, weight: .regular)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
