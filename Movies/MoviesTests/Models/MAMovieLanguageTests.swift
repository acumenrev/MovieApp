//
//  MAMovieLanguageTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import SwiftyJSON
import Nimble


class MAMovieLanguageTests: XCTestCase, MABaseModelTestsProtocol {
    
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
    
    func testInitWithJSON() {
        let data = MAAppUtils.bundleData(fileName: "MovieLanguage", fileType: "json")
        expect(data).notTo(beNil())
        
        let jsonData = JSON(data)
        expect(jsonData).notTo(beNil())
        
        let language = MAMovieLanguageModel.init(jsonData)
        expect(language).notTo(beNil())
    
        expect(language.iso639).to(equal("en"))
        expect(language.language).to(equal("English"))
    }
    
    func testToJSONDict() {
        let language = MAMovieLanguageModel.init(nil)
        expect(language).notTo(beNil())
        
        expect(language.jsonDict()).to(beNil())
    }
    
    func testInitWithEmptyData() {
        let language = MAMovieLanguageModel.init(nil)
        expect(language).notTo(beNil())
        
        expect(language.iso639).to(beNil())
        expect(language.language).to(beNil())
    }
    
}
