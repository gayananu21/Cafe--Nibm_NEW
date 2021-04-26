//
//  RegisterUITest.swift
//  Café-NibmUITests
//
//  Created by Gayan Disanayaka on 4/26/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import XCTest

class RegisterUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    func testRegister() {
        
        let validEmail = "gayan@gmail.com"
         let validPass = "Gayananu21@"
         let phoneNumber = "07782382388"
         let name = "Gayan Disanayaka"
         let rePassword = "Gayananu21@"
         
         let app = XCUIApplication()
         let scrollViewsQuery = app.scrollViews
         scrollViewsQuery.otherElements.containing(.image, identifier:"c1").element.swipeUp()
         
         let elementsQuery = scrollViewsQuery.otherElements
         elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["SIGN UP"]/*[[".buttons[\"SIGN UP\"].staticTexts[\"SIGN UP\"]",".buttons[\"ONREGISTER\"].staticTexts[\"SIGN UP\"]",".staticTexts[\"SIGN UP\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
         scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .textField).element(boundBy: 0).tap()
         
         let element = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).children(matching: .other).element
         let textField = element.children(matching: .textField).element(boundBy: 1)
         
         let userName = element.children(matching: .textField).element(boundBy: 0)
               
               XCTAssertTrue(userName.exists)
               userName.tap()
               userName.typeText(name)
         
         
        let userEmail = textField
         
         XCTAssertTrue(userEmail.exists)
         userEmail.tap()
         userEmail.typeText(validEmail)
         
         
        let userPhoneNumber = element.children(matching: .textField).element(boundBy: 2)
         
         XCTAssertTrue(userPhoneNumber.exists)
         userPhoneNumber.tap()
         userPhoneNumber.typeText(phoneNumber)
         
        let userPassword = element.children(matching: .textField).element(boundBy: 3)
         
         XCTAssertTrue(userPassword.exists)
                userPassword.tap()
                userPassword.typeText(validPass)
         
         let userRePassword = element.children(matching: .textField).element(boundBy: 4)
         
         XCTAssertTrue(userRePassword.exists)
         userRePassword.tap()
         userRePassword.typeText(rePassword)
         
         elementsQuery.buttons["REGISTER"].tap()
         
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
