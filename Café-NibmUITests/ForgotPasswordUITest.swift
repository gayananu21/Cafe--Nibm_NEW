//
//  ForgotPasswordUITest.swift
//  Café-NibmUITests
//
//  Created by Gayan Disanayaka on 4/26/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import XCTest

class ForgotPasswordUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testForgotPassword(){
        
        
                        let validEmail = "gayan@gmail.com"
                        
                        let scrollViewsQuery = XCUIApplication().scrollViews
                        scrollViewsQuery.otherElements.containing(.image, identifier:"c1").element.swipeUp()
                        
                        let elementsQuery2 = scrollViewsQuery.otherElements
                        let elementsQuery = elementsQuery2
                        elementsQuery.staticTexts["FORGOT PASSWORD"].tap()
                        
                        let emailTextField = elementsQuery2.textFields["Your Email"]
                        
                        XCTAssertTrue(emailTextField.exists)
                        emailTextField.tap()
                        emailTextField.typeText(validEmail)
                        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["RESET PASSWORD"]/*[[".buttons[\"RESET PASSWORD\"].staticTexts[\"RESET PASSWORD\"]",".staticTexts[\"RESET PASSWORD\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
               
               
               
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
