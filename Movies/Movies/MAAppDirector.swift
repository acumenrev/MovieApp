//
//  MAAppDirector.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Localize_Swift
import Alamofire

class MAAppDirector: NSObject {

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    var canReachInternet : Bool = false
    var rootWindow : UIWindow!
    
    override init() {
        super.init()
    }
    
    deinit {
        
    }
    
    static func initWithWindow(_ window : UIWindow, launchOptions option : [UIApplicationLaunchOptionsKey: Any]?) -> AppDirector {
        let director = AppDirector()
        director.configWithWindow(window, launchOptions: option)
        
        return director
    }
    
    private func configWithWindow(_ window : UIWindow, launchOptions option : [UIApplicationLaunchOptionsKey: Any]?) {
        self.rootWindow = window
        //        self.removeOldScheduledInAppNotifications()
        
        AppUtils.configLogger()
        self.setupDependencies()
        _ = self.checkLoggedUser()
    }
    
    /// Setup Dependencies
    private func setupDependencies() {
        IQKeyboardManager.sharedManager().enable = true
        self.listenForReachability()
    }
    
    /// Listening network signal
    func listenForReachability(_ completionBlock : ((_ canReachInternet : Bool) -> ())? = nil) {
        self.reachabilityManager?.listener = { status in
            AppUtils.log.info("Network Status Changed: \(status)")
            let statusBefore = self.canReachInternet
            switch status {
            case .notReachable:
                self.canReachInternet = false
            case .unknown:
                self.canReachInternet = false
            default:
                self.canReachInternet = true
            }
            let isWifi = !(self.reachabilityManager?.isReachableOnWWAN)!
            if(statusBefore != self.canReachInternet || self.reachabilityWifi != isWifi){
                // fire a notification to observers
                NotificationCenter.default.post(name: Notification.Name.init(AppConstants.NotificationObserverKeys.canReachInternet), object: nil)
            }
            
            self.reachabilityWifi = isWifi
            
            completionBlock?(self.canReachInternet)
        }
        
        self.reachabilityManager?.startListening()
        
        self.canReachInternet = (self.reachabilityManager?.isReachable)!
        self.reachabilityWifi = !(self.reachabilityManager?.isReachableOnWWAN)!
    }
}
