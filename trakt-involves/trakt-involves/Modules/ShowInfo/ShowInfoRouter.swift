//
//  ShowInfoRouter.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class ShowInfoRouter: ShowInfoRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule(with traktId: String, tvdb: String?, title: String) -> UIViewController {
        guard let viewController = R.storyboard.showInfo.showInfoViewController() else {
            fatalError()
        }
        
        let presenter = ShowInfoPresenter()
        let interactor = ShowInfoInteractor()
        let router = ShowInfoRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        presenter.traktId = traktId
        presenter.title = title
        presenter.tvdb = tvdb
        
        interactor.interactorOutput = presenter

        return viewController
    }
    
    func dismissCurrentScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}