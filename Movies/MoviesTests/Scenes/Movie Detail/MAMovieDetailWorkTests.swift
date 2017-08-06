//
//  MAMovieDetailWorkTests.swift
//  Movies
//
//  Created by admin on 8/6/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import XCTest
import Nimble
import SwiftyJSON
@testable import Movies

class MAMovieDetailWorkTests: XCTestCase {
    
    var worker: Movies.MAMovieDetailWorker!
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
        
        self.worker = Movies.MAMovieDetailWorker(withTableView: self.vc.tblView, movie: self.movieDetail)
        
        expect(self.worker).notTo(beNil())
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
    
  
    
    func testConformingProtocols() {
        expect(self.worker.conforms(to: UITableViewDataSource.self)).to(equal(true))
        expect(self.worker.conforms(to: UITableViewDelegate.self)).to(equal(true))
    }
    
    func testNumberOfSections() {
        expect(self.worker.numberOfSections(in: self.vc.tblView)).to(equal(5))
    }
    
    func testNumberOfRows() {
        expect(self.worker.tableView(self.vc.tblView, numberOfRowsInSection: 0)).to(equal(1))
        expect(self.worker.tableView(self.vc.tblView, numberOfRowsInSection: 1)).to(equal(1))
        expect(self.worker.tableView(self.vc.tblView, numberOfRowsInSection: 2)).to(equal(4))
        expect(self.worker.tableView(self.vc.tblView, numberOfRowsInSection: 3)).to(equal(3))
        expect(self.worker.tableView(self.vc.tblView, numberOfRowsInSection: 4)).to(equal(1))
    }
    
    func testRowHeight() {
        // section 0
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 0, section: 0))).to(equal(UIScreen.main.bounds.width/1.5))
        
        // section 1
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 0, section: 1))).to(equal(UITableViewAutomaticDimension))
        
        // section 2
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 0, section: 2))).to(equal(50))
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 1, section: 2))).to(equal(50))
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 2, section: 2))).to(equal(50))
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 3, section: 2))).to(equal(50))
        
        // section 3
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 0, section: 3))).to(equal(50))
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 1, section: 3))).to(equal(50))
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 1, section: 3))).to(equal(50))
        
        
        // section 4
        expect(self.worker.tableView(self.vc.tblView, heightForRowAt: IndexPath(row: 0, section: 4))).to(equal(50))
    }
    
    func testHeaderHeight() {
        // section 0
        expect(self.worker.tableView(self.vc.tblView, heightForHeaderInSection: 0)).to(equal(0))
        
        // section 1
        expect(self.worker.tableView(self.vc.tblView, heightForHeaderInSection: 1)).to(equal(60))
        
        // section 2
        expect(self.worker.tableView(self.vc.tblView, heightForHeaderInSection: 2)).to(equal(60))
        
        // section 3
        expect(self.worker.tableView(self.vc.tblView, heightForHeaderInSection: 3)).to(equal(60))
        
        // section 4
        expect(self.worker.tableView(self.vc.tblView, heightForHeaderInSection: 4)).to(equal(60))
        
    }
    
    func testHeaderView() {
        // section 0
        expect(self.worker.tableView(self.vc.tblView, viewForHeaderInSection: 0)).to(beNil())
        
        // section 1
        expect(self.worker.tableView(self.vc.tblView, viewForHeaderInSection: 1)).notTo(beNil())
        
        // section 2
        expect(self.worker.tableView(self.vc.tblView, viewForHeaderInSection: 2)).notTo(beNil())
    
        // section 3
        expect(self.worker.tableView(self.vc.tblView, viewForHeaderInSection: 3)).notTo(beNil())
        
        // section 4
        expect(self.worker.tableView(self.vc.tblView, viewForHeaderInSection: 4)).notTo(beNil())
    }
    
    func testCellTypes() {
        // section 0
        expect(self.worker.tableView(self.vc.tblView, cellForRowAt: IndexPath(row: 0, section: 0))).to(beAnInstanceOf(Movies.MAMovieDetailHeaderTableViewCell.self))
        
        // section 1
        expect(self.worker.tableView(self.vc.tblView, cellForRowAt: IndexPath(row: 0, section: 1))).to(beAnInstanceOf(Movies.MAMovieDetailContentTableViewCell.self))
        
        // section 2
        expect(self.worker.tableView(self.vc.tblView, cellForRowAt: IndexPath(row: 0, section: 2))).to(beAnInstanceOf(Movies.MAMovieDetailContentTableViewCell.self))
        
        // section 3
        expect(self.worker.tableView(self.vc.tblView, cellForRowAt: IndexPath(row: 0, section: 3))).to(beAnInstanceOf(Movies.MAMovieDetailContentTableViewCell.self))
        
        // section 4
        expect(self.worker.tableView(self.vc.tblView, cellForRowAt: IndexPath(row: 0, section: 4))).to(beAnInstanceOf(Movies.MAMovieDetailContentTableViewCell.self))
    }
}
