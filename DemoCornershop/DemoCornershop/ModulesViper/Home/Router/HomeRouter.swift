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
}
