//
//  CreateRouter.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol CreateRouterProtocol {
    
    func back()
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
}
