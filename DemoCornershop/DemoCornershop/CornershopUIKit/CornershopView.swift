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

    @IBInspectable public var shadowColor : UIColor{
        get{
            if let color = self.layer.shadowColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.black
            }
        }
        set(newValue){
            self.layer.shadowColor = newValue.cgColor
        }
    }

    @IBInspectable public var shadowOffset : CGSize{
        get{
            return self.layer.shadowOffset
        }
        set(newValue){
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable public var shadowRadius : CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set(newValue){
            self.layer.shadowRadius = newValue
        }
    }

    @IBInspectable public var shadowOpacity : Float{
        get{
            return self.layer.shadowOpacity
        }
        set(newValue){
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderColor: UIColor{
        get{
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set(newValue){
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: Float{
        get{
            return Float(self.layer.borderWidth)
        }
        set(newValue){
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
        
    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = CGFloat(self.borderWidth)
        self.layer.borderColor = self.borderColor.cgColor
    }
}
