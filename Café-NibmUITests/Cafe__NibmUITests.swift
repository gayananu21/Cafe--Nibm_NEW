//
//  Cafe__NibmUITests.swift
//  Café-NibmUITests
//
//  Created by Gayan Disanayaka on 4/26/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import XCTest

class Cafe__NibmUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testLogin () {
        
                                        let validEmail = "gayan@gmail.com"
                                        let validPass = "Gayananu21@"
                                               
                                        let scrollViewsQuery = XCUIApplication().scrollViews
                                        let elementsQuery = scrollViewsQuery.otherElements
                                               
                                        let emailTextField = elementsQuery.textFields["Email"]
                                        XCTAssertTrue(emailTextField.exists)
                                        emailTextField.tap()
                                        emailTextField.typeText(validEmail)
                                            
                                        let passwordTextField = elementsQuery.secureTextFields["Password"]
                                        XCTAssertTrue(passwordTextField.exists)
                                        passwordTextField.tap()
                                        passwordTextField.typeText(validPass)
        
                                        elementsQuery.buttons["LOGIN"].tap()
                                        //scrollViewsQuery.otherElements.containing(.image, identifier:"c1 copy").children(matching: .other).element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
