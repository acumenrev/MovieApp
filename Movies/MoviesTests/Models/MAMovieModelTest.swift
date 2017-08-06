//
//  MAMovieModelTest.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble
import SwiftyJSON

class MAMovieModelTest: XCTestCase, MABaseModelTestsProtocol {
    
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
        let data = MAAppUtils.bundleData(fileName: "Movie", fileType: "json")
        expect(data).notTo(beNil())
        
        let jsonData = JSON(data)
        expect(jsonData).notTo(beNil())
        
        let movie = MAMovieModel.init(jsonData)
        expect(movie).notTo(beNil())
        
        expect(movie.adult).to(equal(false))
        
        expect(movie.backdropPath).to(equal("/1LuzmBWco1YmN7gruhotILN7jxP.jpg"))
        
        expect(movie.genres).notTo(beNil())
        expect(movie.genres?.count).to(equal(4))
        
        expect(movie.id).to(equal(3598))
        
        expect(movie.title).to(equal("Lost Horizon"))
        expect(movie.languages).notTo(beNil())
        expect(movie.languages?.count).to(equal(3))
        expect(movie.originalLanguage).to(equal("en"))
        expect(movie.originalTitle).to(equal("Lost Horizon"))
        expect(movie.overview).to(equal("British diplomat Robert Conway and a small group of civilians crash land in the Himalayas, and are rescued by the people of the mysterious, Eden-like valley of Shangri-la. Protected by the mountains from the world outside, where the clouds of World War II are gathering, Shangri-la provides a seductive escape for the world-weary Conway."))
        expect(movie.popularity).to(equal(0.244398))
        expect(movie.posterPath).to(equal("/lT5DbBkkmOIVvuiTZin5iXIL2Cf.jpg"))
        expect(movie.runtime).to(equal(97))
        
        if let releaseDate = movie.releaseDate as? Date {
            let calendar = Calendar.current
            let dc = calendar.dateComponents([.year, .month, .day], from: releaseDate)
            expect(dc.year).to(equal(1937))
            expect(dc.month).to(equal(9))
            expect(dc.day).to(equal(1))
        }
        
        expect(movie.video).to(equal(false))
        expect(movie.voteCount).to(equal(40))
        expect(movie.voteAverage).to(equal(6.8))
        
    }
    
    func testToJSONDict() {
        let movie = MAMovieModel.init(nil)
        expect(movie).notTo(beNil())
        
        expect(movie.jsonDict()).to(beNil())
    }
    
    func testInitWithEmptyData() {
        let movie = MAMovieModel.init(nil)
        expect(movie).notTo(beNil())
        
        expect(movie.adult).to(beNil())
        
        expect(movie.backdropPath).to(beNil())
        
        expect(movie.genres).to(beNil())
        
        expect(movie.id).to(beNil())
        
        expect(movie.title).to(beNil())
        expect(movie.languages).to(beNil())
        expect(movie.originalLanguage).to(beNil())
        expect(movie.originalTitle).to(beNil())
        expect(movie.overview).to(beNil())
        expect(movie.popularity).to(beNil())
        expect(movie.posterPath).to(beNil())
        expect(movie.runtime).to(beNil())
        
        
        expect(movie.video).to(beNil())
        expect(movie.voteCount).to(beNil())
        expect(movie.voteAverage).to(beNil())
    }
    
}
