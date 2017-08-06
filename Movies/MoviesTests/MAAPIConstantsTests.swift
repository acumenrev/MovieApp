//
//  MAAPIConstants.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble

class MAAPIConstantsTests: XCTestCase {
    
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
    
    func testApiKey() {
    expect(MAAPIConstants.Common.apiKey).to(equal("328c283cd27bd1877d9080ccb1604c91"))
    }
    
    func testGenerateRequestUrl() {
        expect(MAAPIConstants.Common.urlWith("/helloWorld")).to(equal("https://api.themoviedb.org/helloWorld"))
    }
    
    func testGenerateImageUrl() {
        expect(MAAPIConstants.Common.imageUrl(withFileName: "fileName.jpg")).to(equal("https://image.tmdb.org/t/p/w250_and_h141_bestv2/fileName.jpg"))
    }
}
