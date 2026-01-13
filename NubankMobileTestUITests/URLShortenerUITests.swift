//
//  URLShortenerUITests.swift
//  NubankMobileTestUITests
//
//  Created by Jean Carlos on 01/12/25.
//

import XCTest

final class URLShortenerUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_shortenFlow_shouldAddNewItemToList() {
        let textField = app.textFields["urlTextField"]
        XCTAssertTrue(textField.exists)
        
        textField.tap()
        textField.typeText("https://apple.com")
        
        let shortenButton = app.buttons["shortenButton"]
        XCTAssertTrue(shortenButton.exists)
        XCTAssertTrue(shortenButton.isEnabled)
        
        shortenButton.tap()
        
        // Aguarda até 5 segundos o item aparecer na lista
        let shortUrlElement = app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'sho.rt'")).element
        
        let exists = shortUrlElement.waitForExistence(timeout: 5)
        
        XCTAssertTrue(exists, "A URL encurtada não apareceu na lista")
    }
}
