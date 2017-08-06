//
//  MAMovieDetailInteractorTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble
import SwiftyJSON
@testable import Movies


class MAMovieDetailInteractorTests: XCTestCase {
    
    var interactor: Movies.MAMovieDetailInteractor!
    var vc : Movies.MAMovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.setupViewController()
    }
    
    private func setupViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        
        if let vc = storyboard.instantiateViewController(withIdentifier: "MAMovieDetailViewController") as? Movies.MAMovieDetailViewController {
            self.vc = vc
        }
        
        
        expect(self.vc).notTo(beNil())
        
        self.vc.loadView()
        
        self.vc.output?.movie = self.movieDetail
        
        self.interactor = self.vc.output as? Movies.MAMovieDetailInteractor
        
        expect(self.interactor).notTo(beNil())
    }
    
    private var movieDetail : Movies.MAMovieModel {
        get {
            let data = MAAppUtils.bundleData(fileName: "Movie", fileType: "json")
            expect(data).notTo(beNil())
            
            let jsonData = JSON(data)
            expect(jsonData).notTo(beNil())
            
            let movie = Movies.MAMovieModel.init(jsonData)
            
            return movie
        }
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
    
    func testInitialization() {
        expect(self.interactor.output).notTo(beNil())
        expect(self.interactor.movie).notTo(beNil())
    }
    
}