//
//  File.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CornershopView: UIView {

    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
        
    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.cornerRadius
    }
}
