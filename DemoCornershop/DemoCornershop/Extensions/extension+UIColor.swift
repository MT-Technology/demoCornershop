//
//  extension+UIColor.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    public convenience init(hex: String) {
        
        var hexInt : UInt64 = 0
        
        let scanner = Scanner(string: hex)
        scanner.charactersToBeSkipped = CharacterSet.init(charactersIn: "#")
        scanner.scanHexInt64(&hexInt)
        
        let red = CGFloat((hexInt & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hexInt & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
