//
//  MAViewControllerExtensions.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setBackButtonForNextChildItemInNavigationWithTitle(_ title : String) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
}
