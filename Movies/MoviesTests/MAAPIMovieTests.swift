//
//  MAAPIMovieTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble


class MAAPIMovieTests: XCTestCase {
    
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
    
    func testURLs() {
        
        expect(MAAPIConstants.Movies.getMovies).to(equal("/3/discover/movie?api_key=%@&primary_release_date.lte=%@&page=%d"))
        expect(MAAPIConstants.Movies.getMovieDetail).to(equal("/3/movie/%@?api_key=%@"))
        
    }
    
    func testFetchMovies() {
        let expectation = self.expectation(description: "testFetchMoviesWithInvalidPageNumber")
        
        MAAPIMovies.getMovies(with: Date(), pageNumber: 1) { (movies, err) in
            if err == nil {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 15.0) { (err) in
            if let err = err {
                NSLog("testFetchMovies failed: \(err.localizedDescription)")
            }
        }
    }
    
    func testFetchMoviesWithInvalidPageNumber() {
        
        let expectation = self.expectation(description: "testFetchMoviesWithInvalidPageNumber")
        
        MAAPIMovies.getMovies(with: Date(), pageNumber: 0) { (movies, err) in
            if let err = err {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 15.0) { (err) in
            if let err = err {
                NSLog("testFetchMoviesWithInvalidPageNumber failed: \(err.localizedDescription)")
            }
        }
    }
    
    func testFetchMovieDetail() {
        let movieId = "328111"
        
        let expectation = self.expectation(description: "testFetchMovieDetail")
        
        MAAPIMovies.getMovieDetail(movieId) { (movie, err) in
            if err == nil {
                if movie?.id?.string == movieId {
                    expectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 15.0) { (err) in
            if let err = err {
                NSLog("testFetchMovieDetail failed: \(err.localizedDescription)")
            }
        }
    }
    
    func testFetchMovieDetailWithInvalidInfo() {
        let invalidMovieId = "ABSDS"
        
        let expectation = self.expectation(description: "testFetchMovieDetailWithInvalidInfo")
        
        MAAPIMovies.getMovieDetail(invalidMovieId) { (movie, err) in
            if let err = err {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 15.0) { (err) in
            if let err = err {
                NSLog("testFetchMovieDetailWithInvalidInfo failed: \(err.localizedDescription)")
            }
        }
    }
}
