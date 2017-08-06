//
//  MAMoviesWorkerTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble

@testable import Movies

class MAMoviesWorkerTests: XCTestCase {
    
    var worker: Movies.MAMoviesWorker!
    var vc : Movies.MAMoviesViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.setupWorker()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func setupWorker() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MAMoviesViewController") as? Movies.MAMoviesViewController {
            self.vc = vc
        }
        
        expect(self.vc).notTo(beNil())
        
        self.vc.loadView()
        
        self.worker = Movies.MAMoviesWorker(withTableView: self.vc.tblView)
        
        expect(self.worker).notTo(beNil())
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
    
    func testConformingProtocols() {
        expect(self.worker.conforms(to: UITableViewDelegate.self))
        expect(self.worker.conforms(to: UITableViewDataSource.self))
    }
    
    func testNumberOfSections() {
        expect(self.worker.numberOfSections(in: self.vc.tblView)).to(equal(1))
    }
    
    func testNumberOfRows() {
        expect(self.worker.tableView(self.vc.tblView, numberOfRowsInSection: 0)).to(beGreaterThanOrEqualTo(0))
        
    }
    
    func testRowHeight() {
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 0, section: 0))).to(equal(((UIScreen.main.bounds.width - 30)/1.5)))
    }
    
}
