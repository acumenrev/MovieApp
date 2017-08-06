//
//  ViewController.swift
//  Movies
//
//  Created by trivo on 8/4/17.
//  Copyright © 2017 Aduro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MAAPIMovies.getMovies(with: Date(), pageNumber: 1) { (movies, err) in
            print("")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

