//
//  testNityaDemoUITests.swift
//  testNityaDemoUITests
//
//  Created by Arun Sinthanaisirrpi on 2/9/2022.
//

import XCTest

class testNityaDemoUITests: XCTestCase, AutomationInteractable {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHelloLabelExisit() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        waitForElement(
            withId: "HelloWorld",
            withTimeout: 30,
            in: elementExisitCallback(exists:)
        )
    }
    
    func elementExisitCallback(exists: Bool) {
        XCTAssert(exists == true, "Element did not exisits")
    }

  
}
