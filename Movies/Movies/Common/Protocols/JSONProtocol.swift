//
//  JSONProtocol.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import Foundation
import SwiftyJSON


typealias JSONData = JSON
typealias JSONDict = [String : Any]

protocol JSONProtocol {
    init(_ dict : JSONData?)
    func parse(_ dict : JSONData?)
}

extension JSONProtocol {
    var jsonDict : JSONDict? {
        get {
            return nil
        }
    }
}

