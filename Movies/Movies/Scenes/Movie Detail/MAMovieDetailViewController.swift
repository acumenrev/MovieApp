//
//  MAMovieDetailViewController.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright (c) 2017 Tri Vo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol MAMovieDetailViewControllerInput {
    func displaySomething(viewModel: MAMovieDetail.ViewModel)
}

protocol MAMovieDetailViewControllerOutput {
    func doSomething(request: MAMovieDetail.Request)
    func doLoadData(request: MAMovieDetail.Request.UI)
    var movie : MAMovieModel! { get set }
}

class MAMovieDetailViewController: UIViewController, MAMovieDetailViewControllerInput {
    var output: MAMovieDetailViewControllerOutput?
    var router: MAMovieDetailRouter?

    @IBOutlet weak var tblView : UITableView!
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        MAMovieDetailConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomethingOnLoad()
        self.setBackButtonForNextChildItemInNavigationWithTitle("")
        self.title = self.output?.movie.title?.uppercased()
    }

    // MARK: - Event handling

    func doSomethingOnLoad() {
        // NOTE: Ask the Interactor to do some work

        let request = MAMovieDetail.Request.UI(tblView: self.tblView)
        output?.doLoadData(request: request)
    }

    // MARK: - Display logic

    func displaySomething(viewModel: MAMovieDetail.ViewModel) {
        // NOTE: Display the result from the Presenter

        // nameTextField.text = viewModel.name
    }
}

extension MAMovieDetailViewController: MAMovieDetailPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(segue: segue)
    }
}
