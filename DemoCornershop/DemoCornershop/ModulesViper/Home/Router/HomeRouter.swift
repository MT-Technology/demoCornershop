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
    func routeToIncrementOrDecrementAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?)
    func routeToDeleteAlert()
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor(named: "darkYellowCornershop"), forKey: "titleTextColor")
        alert.addAction(cancelAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func routeToCreate(){
        let vc = CreateViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToIncrementOrDecrementAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .cancel, handler: retryHandler)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        retryAction.setValue(UIColor(named: "darkYellowCornershop"), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(named: "darkYellowCornershop"), forKey: "titleTextColor")
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func routeToDeleteAlert(){
        
        let alert = UIAlertController(title: "Couldn’t delete the counter", message: "The Internet connection appears to be offline.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor(named: "darkYellowCornershop"), forKey: "titleTextColor")
        alert.addAction(cancelAction)
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}
