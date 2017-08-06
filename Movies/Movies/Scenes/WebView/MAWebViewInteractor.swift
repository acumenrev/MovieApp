//
//  MAWebViewInteractor.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright (c) 2017 Tri Vo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol MAWebViewInteractorInput {
    func doSomething(request: MAWebView.Request)
}

protocol MAWebViewInteractorOutput {
    func presentSomething(response: MAWebView.Response)
}

class MAWebViewInteractor: MAWebViewInteractorInput {
    var output: MAWebViewInteractorOutput?
    var worker: MAWebViewWorker?

    // MARK: - Business logic

    func doSomething(request: MAWebView.Request) {
        // NOTE: Create some Worker to do the work

        worker = MAWebViewWorker()

        worker?.doSomeWork()

        // NOTE: Pass the result to the Presenter

        let response = MAWebView.Response()
        output?.presentSomething(response: response)
    }
}
