//
//  Document.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/28/20.
//

import Cocoa

class Document: NSDocument {
    /// Represents the document's content.
    var content = Code()
    var contentViewController: ViewController!
    var didReadData = false


    override func makeWindowControllers() {
        // Returns the storyboard that contains your document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        if let windowController =
            storyboard.instantiateController(
                withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as? NSWindowController {
            addWindowController(windowController)
            
            // Set the view controller's represented object as your document.
            if let contentVC = windowController.contentViewController as? ViewController {
                contentVC.representedObject = content
                contentViewController = contentVC
            }
        }
    }

    override func data(ofType typeName: String) throws -> Data {
        if let codeData = content.getCodeText() {
            return codeData
        }
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        if content.use(data: data) {
            // Make didReadData flag true to indicate that data has been read from a file!
            didReadData = true
            return
        }
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override class var autosavesInPlace: Bool {
        return true
    }

}
