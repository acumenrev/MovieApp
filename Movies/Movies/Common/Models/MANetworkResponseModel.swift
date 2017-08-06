//
//  MANetworkResponseModel.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Aduro. All rights reserved.
//

import UIKit


class MANetworkResponseModel: MABaseModel {
    
    private(set) var statusCode : String?
    private(set) var statusMessage : String?
    private(set) var success : Bool = true
    private(set) var errors : [MAAppError]?
    private(set) var jsonData : JSONData?
    
    override init(_ dict: JSONData?) {
        super.init(dict)
        
        
    }
    
    override func parse(_ dict: JSONData?) {
        super.parse(dict)
        jsonData = dict
        self.jsonData = dict
        self.statusCode = dict?.stringForKey("status_code")
        self.statusMessage = dict?.stringForKey("status_message")
        if dict?.existKey("success") == true {
            self.success = dict?.boolForKey("success") ?? true
        }
        
    }

    var appErr : MAAppError {
        get {
            let err = MAAppError.init()
            err.domainName = statusMessage
            err.statusCode = statusCode
            return err
        }
    }
}
