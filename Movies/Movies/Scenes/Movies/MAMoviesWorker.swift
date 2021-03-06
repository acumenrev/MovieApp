//
//  MAMoviesWorker.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright (c) 2017 Tri Vo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import ESPullToRefresh

class MAMoviesWorker : NSObject {
    fileprivate var tblViewMain : UITableView!
    fileprivate lazy var movies = [MAMovieModel]()
    fileprivate var currentPage =  1
    fileprivate var heightOfMovieCard : CGFloat = (UIScreen.main.bounds.width - 30)/1.5
    
    var viewDetailMovie : ((_ moview : MAMovieModel) -> ())?
    
    init(withTableView tbl : UITableView) {
        super.init()
        self.tblViewMain = tbl
        self.tblViewMain.delegate = self
        self.tblViewMain.dataSource = self
        self.config()
        self.setupPullToRefresh()
        
        self.fetchUpcomingMovies()
    }
    
    private func setupPullToRefresh() {
        weak var weakSelf = self
        
        self.tblViewMain.es_addPullToRefresh {
            
            weakSelf?.currentPage = 1
            weakSelf?.fetchUpcomingMovies()
        }
        
        self.tblViewMain.es_addInfiniteScrolling {
            weakSelf?.currentPage += 1
            weakSelf?.fetchUpcomingMovies()
        }
        
    }
    
    private func config() {
        self.tblViewMain.registerCellNib(MAMovieTableViewCell.self)
    }
    
    private func finishRefresh() {
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.tblViewMain.es_stopPullToRefresh()
        }
    }
    
    private func finishLoadMore() {
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.tblViewMain.es_stopLoadingMore()
        }
    }
    
    fileprivate func fetchUpcomingMovies() {
        weak var weakSelf = self
        MAAppUtils.showNetworkActivityIndicator(true)
        MAAPIMovies.getMovies(with: Date(), pageNumber: self.currentPage) { (newMovies, appErr) in
            MAAppUtils.showNetworkActivityIndicator(false)
            if let newMovies = newMovies {
                if weakSelf?.currentPage == 1 {
                    // remove previous results
                    weakSelf?.movies.removeAll()
                    
                    weakSelf?.movies.append(contentsOf: newMovies)
                    
                    weakSelf?.sortMovies()
                    
                    weakSelf?.tblViewMain.reloadData()
                    
                    weakSelf?.finishRefresh()
                } else {
                    // append into existed results
                    
                    weakSelf?.movies.append(contentsOf: newMovies)
                    
                    weakSelf?.sortMovies()
                    
                    weakSelf?.tblViewMain.reloadWithAnimation(.automatic)
                    
                    weakSelf?.finishLoadMore()
                }
            } else if let err = appErr {
                MAAppUtils.showErrorWith(errorObj: err, cancelTitle: "MsgBox.OK".localized(), okTitle: nil, canceHandler: nil, okHandler: nil)
            }
        }
    }
    
    private func sortMovies() {
        movies = movies.sorted(by: {$0.releaseDate.compare($1.releaseDate) == .orderedDescending })
    }
    
    // MARK: - Business Logic
	  
    func doSomeWork() {
        // NOTE: Do the work
    }
}

extension MAMoviesWorker : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return movieCellAt(indexPath, tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfMovieCard
    }
    
    private func movieCellAt(_ idx : IndexPath, _ tableView : UITableView) -> UITableViewCell {
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MAMovieTableViewCell", for: idx) as? MAMovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = self.movies[idx.row]
        myCell.setMovie(movie)
        
        myCell.selectionStyle = .none
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        
        self.viewDetailMovie?(movie)
    }
}


