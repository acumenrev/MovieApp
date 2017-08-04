//
//  MAAppError.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit

class MAAppError: MABaseObject, Error {
    var statusCode : String?
    var domainName : String?
    var userInfo : [String : Any]?
    var data : Data?
    override init() {
        super.init()
    }
    
    init(with statusCode : String, domainName : String, userInfo : [String : Any]? = nil, _ data : Data?) {
        super.init()
        self.statusCode = statusCode
        self.domainName = domainName
        self.userInfo = userInfo
    }

}
