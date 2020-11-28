//
//  ViewController.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/27/20.
//
import Sourceful
import Cocoa

class ViewController: NSViewController, SyntaxTextViewDelegate {

    @IBOutlet weak var editorTextView: SyntaxTextView!
    @IBOutlet weak var outputTextView: NSTextView!
    
    var lexer = SwiftLexer()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear() {
        handleOpenDocumentOperation()
        
        editorTextView.delegate = self
        editorTextView.theme = DefaultSourceCodeTheme()
    }

    func handleOpenDocumentOperation() {
        if let document = self.view.window?.windowController?.document as? Document {
            if document.didReadData {
                populateDocumentContent()
                document.didReadData = false
            }
        }
    }

    func populateDocumentContent() {
        guard let content = representedObject as? Code else { return }
        editorTextView.text = content.contentString
    }
    
    func lexerForSource(_ source: String) -> Lexer {
        return lexer
    }
}

extension ViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        // Updates the contentString property of the Code instance with the text view's text
        (representedObject as? Code)?.contentString = editorTextView.text

    }
}
