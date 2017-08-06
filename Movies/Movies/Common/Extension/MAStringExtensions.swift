//
//  MAStringExtensions.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import Foundation

extension String {
    /**
     Get name of a class
     
     - parameter aClass: Class
     
     - returns: Class name
     */
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
