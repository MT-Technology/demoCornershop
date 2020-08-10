//
//  CornershopTextField.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

@IBDesignable class CornershopTextField: UITextField {

    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
        
    @IBInspectable public var topMargin : CGFloat{
        get{
            return self.edgeMargin.top
        }
        set(newValue){
            self.edgeMargin.top = newValue
        }
    }
    
    @IBInspectable public var leftMargin : CGFloat{
        get{
            return self.edgeMargin.left
        }
        set(newValue){
            self.edgeMargin.left = newValue
        }
    }
    
    @IBInspectable public var rightMargin : CGFloat{
        get{
            return self.edgeMargin.right
        }
        set(newValue){
            self.edgeMargin.right = newValue
        }
    }
    
    @IBInspectable public var bottomMargin : CGFloat{
        get{
            return self.edgeMargin.bottom
        }
        set(newValue){
            self.edgeMargin.bottom = newValue
        }
    }
    
    private var edgeMargin : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
}
