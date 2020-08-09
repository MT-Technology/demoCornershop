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
    func routeToDeleteAlert(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?)
    func routeToCreate()
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
    
    func routeToDeleteAlert(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?){
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
}
