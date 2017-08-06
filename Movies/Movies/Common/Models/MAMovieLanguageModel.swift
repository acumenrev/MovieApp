//
//  MAMovieLanguageModel.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit

class MAMovieLanguageModel: MABaseModel {
    private(set) var iso639 : String?
    private(set) var language : String?
    
    override init(_ dict: JSONData?) {
        super.init(dict)
    }
    
    override func parse(_ dict: JSONData?) {
        super.parse(dict)
        self.iso639 = dict?.stringForKey("iso_639_1")
        self.language = dict?.stringForKey("name")
    }
}
