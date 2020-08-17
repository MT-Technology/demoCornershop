//
//  Counter.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

struct Counter: Codable {
    
    let id: String
    var count: Int
    let title: String
        
    func getTextToShare()->String{
        return "\(count) x \(title)"
    }

}
