//
//  ExampleRouter.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol ExampleRouterProtocol{
    
    func back()
}

class ExampleRouter{
    
    private weak var viewController: ExampleViewController?
    
    init(viewController: ExampleViewController){
        self.viewController = viewController
    }
}

extension ExampleRouter: ExampleRouterProtocol{
    
    func back(){
        viewController?.navigationController?.popViewController(animated: true)
    }
}
