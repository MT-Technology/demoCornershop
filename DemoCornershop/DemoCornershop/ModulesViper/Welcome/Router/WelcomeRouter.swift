//
//  WelcomeRouter.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation


protocol WelcomeRouterProtocol: class{
    func routeToHome()
}

class WelcomeRouter{
    
    private weak var viewController: WelcomeViewController?
    
    init(viewController: WelcomeViewController) {
        self.viewController = viewController
    }
    
}

extension WelcomeRouter: WelcomeRouterProtocol{
    
    func routeToHome(){
        
        guard let view = viewController else {return}
        let vc = HomeViewController()
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
