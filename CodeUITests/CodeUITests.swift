//
//  CodeUITests.swift
//  CodeUITests
//
//  Created by Joshua Rutkowski on 11/30/20.
//

import XCTest

class CodeUITests: XCTestCase {
    var app : XCUIApplication!

    override func setUpWithError() throws {

        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCodeDidExecuteWithButton() {
        let testCode = "1 + 1"
        let window = XCUIApplication().windows["Window"]
        let editorTextView = window.splitGroups.children(matching: .scrollView).element(boundBy: 0).children(matching: .scrollView).element.children(matching: .textView).element
        let outputTextView = window.splitGroups.children(matching: .scrollView).element(boundBy: 1).children(matching: .textView).element
        let runButton = window.toolbars.buttons["Run"]
        
        app.launch()
        XCTAssert(editorTextView.exists)
        XCTAssert(outputTextView.exists)
        XCTAssert(runButton.exists)
        
        editorTextView.typeText(testCode)
        runButton.click()
    }
    
    func testCodeDidExecuteWithMenuItem() {
        let testCode = "1 + 1"
        let window = XCUIApplication().windows["Window"]

        let editorTextView = window.splitGroups.children(matching: .scrollView).element(boundBy: 0).children(matching: .scrollView).element.children(matching: .textView).element
        let productMenuBar = app.menuBars.menuBarItems["Product"]
        
        app.launch()
        XCTAssert(productMenuBar.exists)
        XCTAssert(editorTextView.exists)
        XCTAssert(productMenuBar/*@START_MENU_TOKEN@*/.menuItems["Run"]/*[[".menuBarItems[\"Product\"]",".menus.menuItems[\"Run\"]",".menuItems[\"Run\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists)
        
        editorTextView.typeText(testCode)
        
        productMenuBar.click()
        productMenuBar/*@START_MENU_TOKEN@*/.menuItems["Run"]/*[[".menuBarItems[\"Product\"]",".menus.menuItems[\"Run\"]",".menuItems[\"Run\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.click()
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
