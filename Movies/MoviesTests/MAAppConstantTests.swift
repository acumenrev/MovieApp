//
//  MAAppConstantTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble

class MAAppConstantTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testLogFileName() {
        expect(MAAppConstants.FileName.LogFile).to(equal("Log.txt"))
    }
    
    func testNotificationObserverKeys() {
        expect(MAAppConstants.NotificationObserverKeys.canReachInternet).to(equal("canReachInternet"))
    }
    
    func testDateTimeFormat() {
        expect(MAAppConstants.DateTime.apiFormat).to(equal("YYYY-MM-dd"))
    }
    
}
