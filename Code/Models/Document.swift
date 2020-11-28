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

    override func windowControllerDidLoadNib(_ aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override read(from:ofType:) instead.  If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override class var autosavesInPlace: Bool {
        return true
    }

}
