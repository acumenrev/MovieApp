//
//  MATableViewExtensions.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    /**
     Register cell nib
     
     - parameter cellClass: Cell class
     */
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    /// Reload with animation
    ///
    /// - Parameter animation: Animation
    public func reloadWithAnimation(_ animation : UITableViewRowAnimation) {
        if numberOfSections > 1 {
            let range = IndexSet(0...(numberOfSections - 1))
            self.reloadSections(range, with: animation)
        } else {
            self.reloadData()
        }
    }
}
