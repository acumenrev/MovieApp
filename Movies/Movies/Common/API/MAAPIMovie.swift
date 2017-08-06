//
//  MAAPIMovie.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import Foundation
import Localize_Swift

extension MAAPIConstants {
    struct Movies {
        static let getMovies = "/3/discover/movie?api_key=%@&primary_release_date.lte=%@&page=%d"
        static let getMovieDetail = "/3/movie/%@?api_key=%@"
    }
}

class MAAPIMovies {
    static func getMovies(with releaseDate : Date, pageNumber : Int,
                          _ completionBlock : ((_ movies : [MAMovieModel]?, _ err : MAAppError?) -> ())?) {
        guard pageNumber >= 1 else {
            let appErr = MAAppError.init()
            appErr.domainName = "Msgbox.PageMustBeGreaterThanZero".localized()
            completionBlock?(nil, appErr)
            return
        }
        
        
        let subUrl = String(format: MAAPIConstants.Movies.getMovies, MAAPIConstants.Common.apiKey, MAAppUtils.getStringFromDate(releaseDate, MAAppConstants.DateTime.apiFormat), pageNumber)
        let url = MAAPIConstants.Common.urlWith(subUrl)
        
        _ = MANetworkManager.share.get(withUrl: url, headers: nil, completionBlock: { (response, err) in
            if let err = err {
                completionBlock?(nil, err)
            } else {
                if response?.success == true {
                    var movies = [MAMovieModel]()
                    var movie : MAMovieModel?
                    if let arr = response?.jsonData?["results"].array {
                        for json in arr {
                            movie = MAMovieModel.init(json)
                            if let movie = movie {
                                movies.append(movie)
                            }
                        }
                    }
                    
                    completionBlock?(movies, nil)
                } else {
                    let err = response?.appErr
                    completionBlock?(nil, err)
                }
            }

        })
        
    }
    
    static func getMovieDetail(_ movieId : String,
                               _ completionBlock : ((_ movieInfo : MAMovieModel?, _ err : MAAppError?) -> ())?) {
        let subUrl = String(format: MAAPIConstants.Movies.getMovieDetail, movieId, MAAPIConstants.Common.apiKey)
        let url = MAAPIConstants.Common.urlWith(subUrl)
        
        _ = MANetworkManager.share.get(withUrl: url, headers: nil, completionBlock: { (response, err) in
            if let err = err {
                completionBlock?(nil, err)
            } else {
                if response?.success == true {
                    let movie = MAMovieModel.init(response?.jsonData)
                    completionBlock?(movie,nil)
                } else {
                    let err = response?.appErr
                    completionBlock?(nil, err)
                }
            }
        })
        
    }
}
