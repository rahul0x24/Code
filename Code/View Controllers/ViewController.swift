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
    
    var repl: REPL!
    var lexer = SwiftLexer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds text being processed by the REPL to the outputTextView
        repl = REPL(onStdOut: {[unowned outputTextView] (text) in
            outputTextView?.textStorage?.append(NSAttributedString(string: text, attributes: [.foregroundColor : NSColor.textColor]))
        }, onStdErr: { [unowned outputTextView](text) in
            outputTextView?.textStorage?.append(NSAttributedString(string: text, attributes: [.foregroundColor : NSColor.red]))
        })
    }

    override func viewWillAppear() {
        handleOpenDocumentOperation()
        
        editorTextView.delegate = self
        editorTextView.theme = DarkSourceCodeTheme()
        outputTextView.backgroundColor = #colorLiteral(red: 0.1199501231, green: 0.1244357154, blue: 0.1592445076, alpha: 1)
        outputTextView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
    
    @IBAction func doRunCode(_ sender: Any) {
        outputTextView.string = ""
        let code = editorTextView.text
        let selectedCode = editorTextView.contentTextView.selectedText
        
        if selectedCode != "" {
            repl.execute(selectedCode + "\r\n")
        } else {
            repl.execute(code + "\r\n")
        }
    }
}

extension ViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        // Updates the contentString property of the Code instance with the text view's text
        (representedObject as? Code)?.contentString = editorTextView.text

    }
}
