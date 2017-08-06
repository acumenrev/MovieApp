//
//  MAMovieModel.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit

class MAMovieModel: MABaseModel {
    private(set) var voteCount : Int?
    private(set) var id : Int?
    private(set) var video : Bool?
    private(set) var voteAverage : Float?
    private(set) var title : String?
    private(set) var popularity : Float?
    private(set) var posterPath : String?
    private(set) var originalLanguage : String?
    private(set) var originalTitle : String?
    private(set) var genreIds : Array<Int>?
    private(set) var backdropPath : String?
    private(set) var adult : Bool?
    private(set) var overview : String?
    private(set) var releaseDate : Date = Date()
    private(set) var genres : [MAGenreModel]?
    private(set) var runtime : Int?
    private(set) var languages : [MAMovieLanguageModel]?
    
    override init(_ dict: JSONData?) {
        super.init(dict)
    }
    
    override func parse(_ dict: JSONData?) {
        super.parse(dict)
        weak var weakSelf = self
        self.voteCount = dict?.intForKey("vote_count")
        self.id = dict?.intForKey("id")
        self.video = dict?.boolForKey("video")
        self.voteAverage = dict?.floatForKey("vote_average")
        self.title = dict?.stringForKey("title")
        self.popularity = dict?.floatForKey("popularity")
        self.posterPath = dict?.stringForKey("poster_path")
        self.originalTitle = dict?.stringForKey("original_title")
        self.originalLanguage = dict?.stringForKey("original_language")
        if let dictGenre = dict?["genreIds"].arrayObject as? [Int] {
            self.genreIds = dictGenre
        }
        
        self.backdropPath = dict?.stringForKey("backdrop_path")
        self.adult = dict?.boolForKey("adult")
        self.overview = dict?.stringForKey("overview")
        if dict?.existKey("release_date") == true {
            if let date = dict?.stringForKey("release_date") {
                self.releaseDate = MAAppUtils.getDateFromString(date, MAAppConstants.DateTime.apiFormat) ?? Date()
            }
        }
        
        if let arr = dict?["genres"].array {
            var genre : MAGenreModel?
            genres = [MAGenreModel]()
            _ = arr.map({ (json) in
                genre = MAGenreModel.init(json)
                if let genre = genre {
                    weakSelf?.genres?.append(genre)
                }
            })
        }
        
        if let arr = dict?["spoken_languages"].array {
            var language : MAMovieLanguageModel?
            languages = [MAMovieLanguageModel]()
            _ = arr.map({ (json) in
                language = MAMovieLanguageModel.init(json)
                if let language = language {
                    weakSelf?.languages?.append(language)
                }
            })
        }
        
        self.runtime = dict?.intForKey("runtime")
    }
    
    override func jsonDict() -> JSONDict? {
        return nil
    }

}
