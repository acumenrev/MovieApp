//
//  MAAppUtilsTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble

class MAAppUtilsTests: XCTestCase {
    
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
    
    func testCheckStringNullOrEmpty() {
        
        let str1 = "a"
        let str2 = " "
        var str3 : String?
        let str4 = ""
        let str5 = "\t\n\n\n"
        let str6 = "\t\t\n\nHello World\n\n\t\t"
        expect(MAAppUtils.checkStringNullOrEmpty(str1)).to(equal(false))
        expect(MAAppUtils.checkStringNullOrEmpty(str2)).to(equal(true))
        expect(MAAppUtils.checkStringNullOrEmpty(str3)).to(equal(true))
        expect(MAAppUtils.checkStringNullOrEmpty(str4)).to(equal(true))
        expect(MAAppUtils.checkStringNullOrEmpty(str5)).to(equal(true))
        expect(MAAppUtils.checkStringNullOrEmpty(str6)).to(equal(false))
    }
    
    func testCheckNullString() {
        let str1 = "a"
        let str2 = " "
        var str3 : String?
        let str4 = ""
        let str5 = "\t\n\n\n"
        let str6 = "\t\t\n\nHello World\n\n\t\t"
        expect(MAAppUtils.checkNullString(str1)).to(equal(str1))
        expect(MAAppUtils.checkNullString(str2)).to(equal(""))
        expect(MAAppUtils.checkNullString(str3)).to(equal(""))
        expect(MAAppUtils.checkNullString(str4)).to(equal(""))
        expect(MAAppUtils.checkNullString(str5)).to(equal(""))
        expect(MAAppUtils.checkNullString(str6)).to(equal(str6))
        
    }
    
    func testGetStringFromDate() {
        let df = DateFormatter.init()
        df.locale = .posix
        df.dateFormat = MAAppConstants.DateTime.apiFormat
        let currentTimeString = df.string(from: Date())
        
        let convertedDateString = MAAppUtils.getStringFromDate(Date(), MAAppConstants.DateTime.apiFormat)
        expect(currentTimeString).to(equal(convertedDateString))
    }
    
    func testGetDateFromString() {
        var calendar = Calendar.current
        calendar.locale = .posix
        
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        
        let currentDateString = MAAppUtils.getStringFromDate(Date(), MAAppConstants.DateTime.apiFormat)
        
        let convertedCurrentDate = MAAppUtils.getDateFromString(currentDateString, MAAppConstants.DateTime.apiFormat) ?? Date()
        
        let convertedDateComponents = calendar.dateComponents([.year, .month, .day], from: convertedCurrentDate)
        
        expect(currentDateComponents.year).to(equal(convertedDateComponents.year))
        expect(currentDateComponents.month).to(equal(convertedDateComponents.month))
        expect(currentDateComponents.day).to(equal(convertedDateComponents.day))
        
    }
}
