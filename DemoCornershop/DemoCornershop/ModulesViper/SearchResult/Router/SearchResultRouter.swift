//
//  SearchResultRouter.swift
//  DemoCornershop
//
//  Created by Everis on 8/16/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

protocol SearchResultRouterProtocol {
    
    func routeToAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?, dismissHandler: ((UIAlertAction) -> Void)?)
    func routeToAlert(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?)
}

class SearchResultRouter{
    
    private weak var viewController: SearchResultViewController?
    
    init(viewController: SearchResultViewController) {
        self.viewController = viewController
    }
}

extension SearchResultRouter: SearchResultRouterProtocol{
    
    func routeToAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?, dismissHandler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController.createAlert(title: title, message: message, retryHandler: retryHandler, dismissHandler: dismissHandler)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func routeToAlert(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController.createAlert(title: title, message: message, dismissHandler: dismissHandler)
        viewController?.present(alert, animated: true, completion: nil)
    }
}

