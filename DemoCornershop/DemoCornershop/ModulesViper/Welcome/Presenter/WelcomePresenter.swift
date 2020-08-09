//
//  WelcomePresenter.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol WelcomePresenterProtocol: class{
    
    func loadContent()
    func getFeatureCount() -> Int
    func getFeatureAtIndexPath(indexPath: IndexPath) -> Feature
    func enterToApp()
}

class WelcomePresenter{
    
    private weak var view: WelcomeViewProtocol?
    private var router: WelcomeRouterProtocol
    private var interactor: WelcomeInteractorProtocol
    
    private var features: [Feature] = []
    
    init(viewController: WelcomeViewController) {
        
        view = viewController
        router = WelcomeRouter(viewController: viewController)
        interactor = WelcomeInteractor()
    }
    
}

extension WelcomePresenter: WelcomePresenterProtocol{
    
    func loadContent(){
        features = interactor.getFeatures()
        view?.reloadData()
    }
    
    func getFeatureCount() -> Int{
        features.count
    }
    
    func getFeatureAtIndexPath(indexPath: IndexPath) -> Feature{
        features[indexPath.row]
    }
    
    func enterToApp(){
        router.routeToHome()
    }
}
