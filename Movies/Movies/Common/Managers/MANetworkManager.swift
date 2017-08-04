//
//  NetworkManager.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Aduro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MANetworkManager: MABaseManager {
    enum ContentType : String {
        case json = "application/json"
        case form = "application/x-www-form-urlencoded"
    }
    
    var sessionManager : Alamofire.SessionManager?
    
    static var share : MANetworkManager = {
        MANetworkManager()
    }()
    
    private override init() {
        super.init()
        self.config()
    }
    
    deinit {
        
    }
    
    private func config() {
        let configuration = urlSessionConfiguration()
        
        sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }
    
    /// Session Configuration
    ///
    /// - Returns: URLSessionConfiguration
    private func urlSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        /*
        if AppDelegate.originDelegate.director?.canReachInternet == true  {
            configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        } else {
            configuration.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataDontLoad
        }
        */
        
        configuration.timeoutIntervalForRequest = 15
        configuration.allowsCellularAccess = true
        configuration.networkServiceType = .default
        
        return configuration
    }
    
    func removeCachedResponses() {
        URLCache.shared.removeAllCachedResponses()
    }
    
    /// HTTP Error Code
    ///
    /// - Unauthorized: Unauthoirzed
    /// - NoInternet: No internet connection
    public enum HTTPErrorCode : Int {
        case Unauthorized = 401
        case NoInternet = -1009
        case NotFound = 404
        case CannotConnectToToHost = -1004
        case ConnectionLost = -1005
        case DNSLookupFailed = -1006
        case ResourceUnvailable = -1008
        case BadServerResponse = -1011
        case FileDoesNotExist = -1100
        case InternationalRoamingOff = -1018
        case ServerError = 500
        
        static let networkErrorCodes = [NoInternet, CannotConnectToToHost, ConnectionLost, DNSLookupFailed, ResourceUnvailable, BadServerResponse, FileDoesNotExist, InternationalRoamingOff]
    }
    
    var sessionManagerWithoutConfiguration : Alamofire.SessionManager {
        get {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 15
            configuration.allowsCellularAccess = true
            configuration.networkServiceType = .default
            
            return Alamofire.SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
        }
    }
    
    fileprivate func parseErrorFromResponse(_ error : Error?, _ res : DataResponse<Any>?) -> AppError? {
        guard let error = error else { return nil }
        
        let appErr = AppError()
        appErr.data = res?.data
        var domainName = ""
        
        if let statusCode = res?.response?.statusCode {
            appErr.statusCode = statusCode.string
        } else {
            if let afError = error as? AFError {
                switch afError {
                case .invalidURL(let url):
                    domainName = "Invalid URL: \(url) - \(error.localizedDescription)"
                case .parameterEncodingFailed(let reason):
                    domainName = "Parameter encoding failed: \(afError.localizedDescription)"
                    domainName.append("\nFailure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    domainName = "Multipart encoding failed: \(afError.localizedDescription)"
                    domainName.append("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    domainName = "Response validation failed: \(afError.localizedDescription)"
                    domainName.append("\nFailure Reason: \(reason)\n")
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        domainName.append("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        domainName.append("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        domainName.append("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        domainName.append("Response status code was unacceptable: \(code)")
                    }
                case .responseSerializationFailed(let reason):
                    domainName.append("Response serialization failed: \(error.localizedDescription)\n")
                    domainName.append("Failure Reason: \(reason)")
                }
                appErr.statusCode = afError.responseCode?.string
            } else if let afError = error as? URLError {
                appErr.statusCode = afError.errorCode.string
                appErr.userInfo = afError.errorUserInfo
                appErr.domainName = afError.localizedDescription
            }
        }
        
        appErr.domainName = domainName
        
        return appErr
    }
    
    fileprivate var noCacheHeaders : [String : String] {
        get {
            return ["Cache-Control": "no-cache, no-store, must-revalidate"]
        }
    }
    
    var userHeaders : [String : String] {
        get {
            return ["Accept-Language" : "en",
                    "Authorization" : ""]
        }
    }
    
    fileprivate func httpBody(with params : Any?, contentType : ContentType) -> Data? {
        guard let params = params else {
            return nil
        }
        
        var data : Data?
        
        if contentType == .json {
            data = try? JSONSerialization.data(withJSONObject: params, options: [])
        } else if contentType == .form {
            var form = ""
            if let params = params as? [String : Any] {
                for instance in params {
                    form = form.appendingFormat("%@=%@", instance.key, instance.value as! CVarArg)
                }
            }
            
            data = form.data(using: .utf8, allowLossyConversion: false)
        }
        
        
        return data
    }
}

