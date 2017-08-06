//
//  MAAppErrorTest.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble

class MAAppErrorTest: XCTestCase {
    
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
    
    func testInitWithEmpty() {
        let appErr = MAAppError.init()
        expect(appErr).notTo(beNil())
        
        expect(appErr.data).to(beNil())
        expect(appErr.domainName).to(beNil())
        expect(appErr.statusCode).to(beNil())
        expect(appErr.userInfo).to(beNil())
    }
    
    func testInitWithFullData() {
        let data = MAAppUtils.bundleData(fileName: "MovieLanguage", fileType: "json")
        
        let appErr = MAAppError.init(with: "2", domainName: "Sample Error", userInfo: ["test" : "helloworld"], data)
        
        expect(appErr).notTo(beNil())
        expect(appErr.statusCode).to(equal("2"))
        expect(appErr.domainName).to(equal("Sample Error"))
        expect(appErr.userInfo).notTo(beNil())
        
        expect(appErr.userInfo?["test"]).notTo(beNil())
        if let value = appErr.userInfo?["test"] as? String {
            expect(value).to(equal("helloworld"))
        }
       
        expect(appErr.data).to(equal(data))
        
    }
    
}
