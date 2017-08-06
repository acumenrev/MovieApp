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
    
    static func initWithWindow(_ window : UIWindow, launchOptions option : [UIApplicationLaunchOptionsKey: Any]?) -> MAAppDirector {
        let director = MAAppDirector()
        director.configWithWindow(window, launchOptions: option)
        
        return director
    }
    
    
    
    private func configWithWindow(_ window : UIWindow, launchOptions option : [UIApplicationLaunchOptionsKey: Any]?) {
        self.rootWindow = window
        
        MAAppUtils.configLogger()
        self.setupDependencies()
        
        self.setupInitialScene()
    }
    
    private func setupInitialScene() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            
            rootWindow.rootViewController = vc
            rootWindow.makeKeyAndVisible()
        }
    }
    
    /// Setup Dependencies
    private func setupDependencies() {
//        IQKeyboardManager.sharedManager().enable = true
        self.listenForReachability()
    }
    
    /// Listening network signal
    func listenForReachability(_ completionBlock : ((_ canReachInternet : Bool) -> ())? = nil) {
        self.reachabilityManager?.listener = { status in
            MAAppUtils.log.info("Network Status Changed: \(status)")
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
            if(statusBefore != self.canReachInternet){
                // fire a notification to observers
                NotificationCenter.default.post(name: Notification.Name.init(MAAppConstants.NotificationObserverKeys.canReachInternet), object: nil)
            }
            
            
            completionBlock?(self.canReachInternet)
        }
        
        self.reachabilityManager?.startListening()
        
        self.canReachInternet = (self.reachabilityManager?.isReachable)!

    }
}
