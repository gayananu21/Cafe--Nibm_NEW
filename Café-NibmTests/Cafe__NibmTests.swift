//
//  Cafe__NibmTests.swift
//  Café-NibmTests
//
//  Created by Gayan Disanayaka on 2/22/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import XCTest
@testable import Café_Nibm
class Cafe__NibmTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    
    func testLoginValidation(){
        
        let email = "gayan@gmail.com"
        let password = "Gayananu21@"
        
        
        let cleanedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        
        if(Utilities.isValidEmail(cleanedEmail) && Utilities.isPasswordValid(cleanedPassword) == true){
            
            XCTAssertEqual("gayan@gmail.com", cleanedEmail)
            XCTAssertEqual("Gayananu21@", cleanedPassword)
            
        }
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
