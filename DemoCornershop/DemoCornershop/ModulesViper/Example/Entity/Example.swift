//
//  Example.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

struct Example: Codable {
    
    let name: String
    let options: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case options = "data"
    }

}
