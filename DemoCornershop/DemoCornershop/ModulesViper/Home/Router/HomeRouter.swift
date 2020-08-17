//
//  HomeRouter.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {

    func routeToShare(textToShare: String)
    func routeToDeleteActionSheet(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?)
    func routeToCreate()    
    func routeToAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?, dismissHandler: ((UIAlertAction) -> Void)?)
    func routeToAlert(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?)
}

class HomeRouter{
    
    private weak var viewController: HomeViewController?
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeRouterProtocol{
    
    func routeToShare(textToShare: String){
        let shareVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        viewController?.present(shareVC, animated: true, completion: nil)
    }
    
    func routeToDeleteActionSheet(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete \(itemsToDelete) counter", style: .destructive, handler: handler))
        let cancelAction = UIAlertAction(title: Message.Alert.ButtonName.cancel, style: .cancel, handler: nil)
        cancelAction.setCornershopStyle()
        alert.addAction(cancelAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func routeToCreate(){
        let vc = CreateViewController()
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
