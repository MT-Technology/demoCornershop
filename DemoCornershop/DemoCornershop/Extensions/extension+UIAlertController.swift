//
//  extension+UIAlertController.swift
//  DemoCornershop
//
//  Created by Everis on 8/17/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{
    
    static func createAlert(title: String, message: String, retryHandler: ((UIAlertAction) -> Void)?, dismissHandler: ((UIAlertAction) -> Void)?) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: Message.Alert.ButtonName.retry, style: .cancel, handler: retryHandler)
        let dismissAction = UIAlertAction(title: Message.Alert.ButtonName.dismiss, style: .default, handler: dismissHandler)
        retryAction.setCornershopStyle()
        dismissAction.setCornershopStyle()
        alert.addAction(retryAction)
        alert.addAction(dismissAction)
        return alert
    }
    
    static func createAlert(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: Message.Alert.ButtonName.dismiss, style: .cancel, handler: dismissHandler)
        dismissAction.setCornershopStyle()
        alert.addAction(dismissAction)
        return alert
    }
}
