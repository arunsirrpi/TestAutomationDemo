//
//  AutomationInteractable.swift
//  testNityaDemoUITests
//
//  Created by Arun Sinthanaisirrpi on 2/9/2022.
//

import Foundation
//
//  AutomationInteractable.swift
//  KIDSiviewUITests
//
//  Created by Bhanu Neeli on 10/10/18.
//  Copyright © 2018 Australian Broadcasting Corporation. All rights reserved.
//

import XCTest

/// Callback used mainly for the wait for element to appear
/// - parameter Bool: indicating if the element appeared
/// - return: Void
public typealias WaitForElementCallback = (_ elementExisits: Bool) -> Void

/// Simple protocol with base implementation which we can use to write
/// scalable UI tests. These are bunch of utility function
/// which will help with interacting with all the available functions
public protocol AutomationInteractable {
    
    /// Tap a collection view cell with the id
    /// - parameter withId: String name(UIAccessiblityIdentifier) of the cell
    func tapCollectionViewCell(withId id: String)
    
    /// Get the cell of an collection view cell with id
    /// - parameter withId: String name(UIAccessiblityIdentifier) of the cell
    func collectionViewCell(wihtId id: String) -> XCUIElement
    
    /// Simple function to tap tableview with the id
    /// - parameter withId: String name(UIAccessiblityIdentifier) of the cell
    func tapTableViewCell(withId id: String)
    
    /// Simple function to return the UITableview Cell
    /// - parameter withId: String name(UIAccessiblityIdentifier) of the element
    /// - returns: an ```XCUIElement```
    func tableViewCell(withId id: String) -> XCUIElement
    
    /// Simple function that will return the element named
    /// This is the core of finding the element, we can use this to find any element
    /// - parameter withId: String name(UIAccessiblityIdentifier) of the element
    /// - returns: an ```XCUIElement```
    func element(withId id: String) -> XCUIElement
    
    /// Simple function that will return the element with static text of the label
    /// - parameter withTxt: Partial text of the label
    /// - returns: an ```XCUIElement```
    func elementWithPartialText(withTxt txt: String) -> XCUIElement
    
    /// Simple function to tap on an UI element with the id
    /// - parameter withId: String name(UIAccessiblityIdentifier) of the UI element
    func tapOnElement(withId id: String)
    
    /// Wait for an element to exists
    /// - parameter withId: String name(UIAccessiblityIdentifier) of the element
    /// - parameter withTimeout: Double duration to wait
    /// - parameter in: Callback of type ```WaitForElementCallback```
    func waitForElement(
        withId id: String,
        withTimeout timeout:Double,
        in callback: WaitForElementCallback)
    
    func waitForElementToAppear(withId id: XCUIElement) -> Bool
    
    /// Get the current device name on which the app is running
    /// - returns: device name
    func getCurrentDeviceName() -> String
    
    func waitForListToLoad(
        withId id: XCUIElement,
        withTimeout timeout:Double,
        in callback: WaitForElementCallback)
    
    func tapCoordinate(at xCoordinate: Double, and yCoordinate: Double)
    
    func scrollToElement(withId id: XCUIElement)
    
    func textView(withId id: String) -> XCUIElement
    
    func button(withId id: String) -> XCUIElement
    
    func tapOnButton(withId id: String)
}


//MARK:- CollectionView
public extension AutomationInteractable {
    
    func tapCollectionViewCell(withId id: String) {
        collectionViewCell(wihtId: id).tap()
    }
    
    func collectionViewCell(wihtId id: String) -> XCUIElement {
        return XCUIApplication().collectionViews.cells[id]
    }
}

//MARK:- Tableview
public extension AutomationInteractable {
    
    func tapTableViewCell(withId id: String) {
        tableViewCell(withId: id).tap()
    }
    
    func tableViewCell(withId id: String) -> XCUIElement {
        return XCUIApplication().tables.cells[id]
    }
}

//MARK:- TextView
public extension AutomationInteractable {
    func textView(withId id:String) -> XCUIElement {
        return XCUIApplication().textViews[id]
    }
}

//MARK:- Element lookup by id
public extension AutomationInteractable {
    func element(withId id: String) -> XCUIElement {
        return XCUIApplication()
            .descendants(matching: .any)
            .matching(identifier: id)
            .element
    }
    
    func elementWithPartialText(withTxt txt: String) -> XCUIElement {
        return XCUIApplication()
            .staticTexts
            .matching(NSPredicate(format: txt))
            .element(boundBy: 0)
    }
  
    func tapOnElement(withId id: String) {
        element(withId: id).tap()
    }
    
    func waitForElement(
        withId id: String,
        withTimeout timeout:Double,
        in callback: WaitForElementCallback) {
        /// Get the element
        let elementExists = element(withId: id).waitForExistence(timeout: timeout)
        callback(elementExists)
    }
    
    func waitForElementToAppear(withId id: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: id)
        let result = XCTWaiter().wait(for: [expectation], timeout: 10)
        return result == .completed
    }
    
    func waitForListToLoad(
        withId id: XCUIElement,
        withTimeout timeout:Double,
        in callback: WaitForElementCallback) {
        ///Get the list
        let listExists = id.waitForExistence(timeout: timeout)
        callback(listExists)
    }
}
public extension AutomationInteractable {
    
    func getCurrentDeviceName() -> String {
        return UIDevice.current.name
    }
    
    func tapCoordinate(at xCoordinate: Double, and yCoordinate: Double) {
        let normalized = XCUIApplication().coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
        coordinate.tap()
    }
    
    func button(withId id: String) -> XCUIElement{
        return XCUIApplication().buttons[id]
    }
    
    func tapOnButton(withId id: String) {
        button(withId: id).tap()
    }
    
    func scrollToElement(withId id: XCUIElement) {
        if case .phone = UIDevice.current.userInterfaceIdiom {
            while !id.exists{
                XCUIApplication().swipeUp()
            }
        } else {
            while !id.exists{
                XCUIApplication().swipeLeft()
        }
    }
}

}
