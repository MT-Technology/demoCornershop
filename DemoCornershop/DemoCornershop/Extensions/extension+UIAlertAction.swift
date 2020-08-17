//
//  extension+UIAlertAction.swift
//  DemoCornershop
//
//  Created by Everis on 8/17/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertAction{
    
    func setCornershopStyle(){
        self.setValue(Color.darkYellow, forKey: "titleTextColor")
    }
}
