//
//  MAGenreModel.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit

class MAGenreModel: MABaseModel {
    
    private(set) var genreId : Int?
    private(set) var genre : String?
    
    override init(_ dict: JSONData?) {
        super.init(dict)
    }
    
    override func parse(_ dict: JSONData?) {
        super.parse(dict)
        
        genreId = dict?.intForKey("id")
        genre = dict?.stringForKey("name")

    }
}
