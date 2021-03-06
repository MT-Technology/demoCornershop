//
//  CreateRouter.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

protocol CreateRouterProtocol {
    
    func back()
    func routeToExamples()
    func routeToAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?, dismissHandler: ((UIAlertAction) -> Void)?)
    func routeToAlert(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?)
}

class CreateRouter{
    
    private weak var viewController: CreateViewController?
    
    init(viewController : CreateViewController) {
        self.viewController = viewController
    }
}

extension CreateRouter: CreateRouterProtocol{
    
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToExamples(){
        
        let vc = ExampleViewController()
        vc.delegate = viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?, dismissHandler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController.createAlert(title: title, message: message, retryHandler: retryHandler, dismissHandler: dismissHandler)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func routeToAlert(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController.createAlert(title: title, message: message, dismissHandler: dismissHandler)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
