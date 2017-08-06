//
//  MAGenreModelTest.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble
import SwiftyJSON

class MAGenreModelTest: XCTestCase, MABaseModelTestsProtocol {
    
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
        let data = MAAppUtils.bundleData(fileName: "Genre", fileType: "json")
        expect(data).notTo(beNil())
        
        let jsonData = JSON(data)
        expect(jsonData).notTo(beNil())
        
        let genre = MAGenreModel.init(jsonData)
        expect(genre).notTo(beNil())
        
        expect(genre.genreId).to(equal(16))
        
        expect(genre.genre).to(equal("Animation"))
    }
    
    func testToJSONDict() {
        let genre = MAGenreModel.init(nil)
        
        expect(genre).notTo(beNil())
        
        expect(genre.jsonDict()).to(beNil())
    }
    
    func testInitWithEmptyData() {
        let genre = MAGenreModel.init(nil)
        
        expect(genre).notTo(beNil())
        
        expect(genre.genreId).to(beNil())
        expect(genre.genre).to(beNil())
    }
}
