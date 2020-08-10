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
    func routeToConfirmAlert(name: String)
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
    
    func routeToConfirmAlert(name: String){
        
        let alert = UIAlertController(title: "Counter App", message: "Your \"\(name)\" counter has been created", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "dismiss", style: .cancel) { [weak self](action) in
            guard let welf = self else {return}
            welf.back()
        }
        dismissAction.setValue(UIColor(named: "darkYellowCornershop"), forKey: "titleTextColor")
        alert.addAction(dismissAction)
        viewController?.present(alert, animated: true, completion: nil)
        
    }
}
