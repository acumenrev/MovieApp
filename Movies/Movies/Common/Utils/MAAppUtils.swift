//
//  MAAppUtils.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit
import XCGLogger
import SVProgressHUD
import Kingfisher
import Alamofire
import SwiftyJSON
import Localize_Swift
import SwifterSwift

class MAAppUtils: MABaseObject {
    static let share : MAAppUtils = {
        MAAppUtils()
    }()
    
    public enum DayOfWeek:Int{
        case sun = 0
        case mon = 1
        case tue = 2
        case wed = 3
        case thu = 4
        case fri = 5
        case sat = 6
    }
    
    private override init() {
        MAAppUtils.configLogger()
    }
    
    deinit {
        
    }
    
    static var log : XCGLogger!
    
    static func configLogger() {
        log = XCGLogger.default
        
        
        let pathLogFile = self.pathForLogFile
        log.setup(level: .debug, showLogIdentifier: false, showFunctionName: true, showThreadName: false, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: pathLogFile, fileLevel: nil)
        
        // format log levels
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
        emojiLogFormatter.apply(prefix: "💣💣💣 ", postfix: " 💣💣💣", to: .severe)
        log.formatters = [emojiLogFormatter]
        
        // log app details
        log.logAppDetails()
    }
    
    private static var pathForLogFile : URL? {
        get {
            var logFile : URL?
            #if DEBUG
                // let logPath: URL = appDelegate.documentsDirectory.appendingPathComponent("XCGLogger_Log.txt")
                logFile = documentsDirectory.appendingPathComponent(MAAppConstants.FileName.LogFile)
            #endif
            
            return logFile
        }
    }
    
    static let documentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    static let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    private static var logSystemDestination : AppleSystemLogDestination {
        get {
            // Create a destination for the system console log (via NSLog)
            let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.systemDestination")
            
            // Optionally set some configuration options
            systemDestination.outputLevel = .debug
            systemDestination.showLogIdentifier = false
            systemDestination.showFunctionName = true
            systemDestination.showThreadName = true
            systemDestination.showLevel = true
            systemDestination.showFileName = true
            systemDestination.showLineNumber = true
            systemDestination.showDate = true
            
            return systemDestination
        }
    }
    
    /**
     Check string NULL or EMPTY
     
     - parameter value: String balue need to be checked
     
     - returns: true if value is null or empty
     */
    static func checkStringNullOrEmpty(_ value : String?) -> Bool {
        if value == nil {
            return true
        }
        
        if value!.isEmpty {
            return true
        }
        
        
        let newValue = value!.replacingOccurrences(of: " ", with: "")
        if newValue.isEmpty {
            return true
        }
        
        // whitespace
        let whiteSpace = CharacterSet.whitespacesAndNewlines
        if let range = value!.rangeOfCharacter(from: whiteSpace) {
            let count = value!.trimmingCharacters(in: whiteSpace).characters.count
            if count > 0 {
                return false
            }
            return true
        }
        
        return false
    }
    
    /**
     Checks string is NULL
     
     - parameter value: String value need to be checked
     
     - returns: return true
     */
    static func checkNullString(_ value : String?) -> String {
        if value == nil {
            return ""
        }
        
        if self.checkStringNullOrEmpty(value) == true {
            return ""
        }
        
        return value!
    }
    
    /// Show HUD
    ///
    /// - Parameter isShow: Show or Hide
    static func showHud(_ isShow : Bool) {
        if (isShow == true) {
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.show()
        } else {
            UIApplication.shared.endIgnoringInteractionEvents()
            SVProgressHUD.dismiss()
        }
    }
    
    /// Get date from string with specific format
    ///
    /// - Parameters:
    ///   - value: String value
    ///   - fmt: Format string
    /// - Returns: Date
    static func getDateFromString(_ value : String?, _ format: String) -> Date? {
        
        let dateFormmater = DateFormatter()
        dateFormmater.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormmater.dateFormat =  format
        dateFormmater.locale = .posix
        
        guard let val = value else {
            return nil
        }
        
        guard let date = dateFormmater.date(from: val) else {
            return nil
        }
        
        return date
    }

    
    /// Get string from date with specific format
    ///
    /// - Parameters:
    ///   - value: Date
    ///   - format: Date Format
    /// - Returns: String
    static func getStringFromDate(_ value : Date, _ format : String) -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormmater.dateFormat =  format
        dateFormmater.locale = .posix
        
        return dateFormmater.string(from: value)
    }
    
    /// Load a remote image on UIImageView object
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - imgView: UIImageView
    ///   - placeHolderImg: Placeholder image
    static func loadRemoteImage(fromURL url : String?, onView imgView : UIImageView?, withPlaceholderImage placeHolderImg : UIImage? = nil, applyCenterPlaceholder centerEffect : Bool? = false, _ completionBlock : ((_ img : UIImage?) -> ())? = nil) {
        guard imgView != nil else {
            return
        }
        
        if self.checkStringNullOrEmpty(url) == true {
            imgView?.image = placeHolderImg
        } else {
            let url = URL(string: (url)!)
            imgView?.kf.indicatorType = .activity
            if centerEffect != nil && placeHolderImg != nil {
                if centerEffect == false {
                    imgView?.kf.setImage(with: url, placeholder: placeHolderImg, options: [.transition(.fade(0.2))])
                } else {
                    imgView?.contentMode = .scaleAspectFit
                    imgView?.kf.setImage(with: url, placeholder: placeHolderImg, options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: { (img, _, _, _) in
                        completionBlock?(img)
                        if img !=  nil {
                            imgView?.contentMode = .scaleAspectFill
                        }
                    })
                }
                
            } else {
                imgView?.kf.setImage(with: url, placeholder: placeHolderImg, options: [.transition(.fade(0.2))])
            }
            
        }
    }
    
    /// Show/Hide network activity indicator
    ///
    /// - Parameter show: True is show, false is hide
    static func showNetworkActivityIndicator(_ show : Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    /// Cancal download remote iamge
    ///
    /// - Parameter imgView: ImageView
    static func cancelDownloadingRemoteImage(on imgView : UIImageView) {
        imgView.kf.cancelDownloadTask()
    }
    
    
    /// Data from bundle
    ///
    /// - Parameters:
    ///   - name: File name
    ///   - type: File type
    /// - Returns: Data
    static func bundleData(fileName name : String, fileType type : String) -> Data? {
        
        guard let path = Bundle.main.path(forResource: name, ofType: type) else { return nil }
        
        let url = URL(fileURLWithPath: path)
        
        let data = try? Data(contentsOf: url)
        
        return data
    }
    
    /// Show an alert on UI
    ///
    /// - Parameters:
    ///   - title: Title
    ///   - msg: Message
    ///   - cancel: Cancel title
    ///   - OKTitle: OK title
    ///   - cancelhandler: Cancel handler
    ///   - okHandler: OK handler
    static func showAlertWith(Title title : String?, Message msg : String?, CancelTitle cancel : String?, OKTitle : String?,
                              CancelHandler cancelhandler : (() -> ())? ,
                              OKHandler okHandler : (() -> ())?,_ isOnpresented: Bool? = false) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        if (MAAppUtils.checkStringNullOrEmpty(cancel) == false) {
            let action = UIAlertAction(title: cancel, style: .cancel, handler: { (action) in
                cancelhandler?()
            })
            
            alertController.addAction(action)
        }
        
        if (MAAppUtils.checkStringNullOrEmpty(OKTitle) == false) {
            let action = UIAlertAction(title: OKTitle, style: .default, handler: { (action) in
                okHandler?()
            })
            
            alertController.addAction(action)
        }
        
        if(isOnpresented != nil && isOnpresented!){
            alertController.modalPresentationStyle = .overCurrentContext
            alertController.modalTransitionStyle = .crossDissolve
        }
        
        AppDelegate.originDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /// Show error from error object
    ///
    /// - Parameters:
    ///   - err: Error object
    ///   - cancel: Cancel title
    ///   - okText: Ok title
    ///   - cancelhandler: Cancel handler
    ///   - okhandler: OK Handler
    static func showErrorWith(errorObj err : Error, cancelTitle cancel : String?, okTitle okText : String?,
                              canceHandler cancelhandler : (() -> ())?,
                              okHandler okhandler : (() -> ())?) {
        var msg = ""
        if err is MAAppError {
            let error = err as! MAAppError
            msg = MAAppUtils.checkNullString(error.domainName)
        } else {
            msg = err.localizedDescription
        }
        
        showAlertWith(Title: "MsgBox.Error".localized(), Message: msg, CancelTitle: cancel, OKTitle: okText, CancelHandler: cancelhandler, OKHandler: okhandler)
    }
}
