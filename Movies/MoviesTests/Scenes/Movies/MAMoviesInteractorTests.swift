//
//  MAMoviesInteractorTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble

@testable import Movies

class MAMoviesInteractorTests: XCTestCase {
    
    var interactor: Movies.MAMoviesInteractor!
    var vc : Movies.MAMoviesViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.setupInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func setupInteractor() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MAMoviesViewController") as? Movies.MAMoviesViewController {
            self.vc = vc
        }
        
        expect(self.vc).notTo(beNil())
        
        self.vc.loadView()
        
        self.interactor = self.vc.output as? Movies.MAMoviesInteractor
        
        expect(self.interactor).notTo(beNil())
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
