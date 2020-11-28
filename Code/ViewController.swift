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
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

