//
//  MABaseModel.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Aduro. All rights reserved.
//

import UIKit

class MABaseModel: MABaseObject {
    override init() {
        super.init()
    }
    
    init(_ dict: JSONData?) {
        super.init()
        self.parse(dict)
    }
    
    
    func parse(_ dict: JSONData?) {
        guard dict != nil else { return }
    }
    
    func jsonDict() -> JSONDict? {
        return nil
    }
}
