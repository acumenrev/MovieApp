//
//  MAAPIConstants.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import Foundation

struct MAAPIConstants {
    struct Common {
        private static var serverUrl : String {
            get {
                return "https://api.themoviedb.org"
            }
        }
        
        private static var imageServerUrl : String {
            get {
                return "https://image.tmdb.org/t/p/w250_and_h141_bestv2/"
            }
        }
        
        static var apiKey : String {
            get {
                return "328c283cd27bd1877d9080ccb1604c91"
            }
        }
        
        static func urlWith(_ subUrl : String) -> String {
            return serverUrl.appending(subUrl)
        }
        
        static func imageUrl(withFileName fileName : String) -> String {
            return imageServerUrl.appending(fileName)
        }
    }
}
