//
//  Example.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

struct Example {
    
    let name: String
    let options: [String]
    
    init(json: [String:Any]) {
        
        name = json["title"] as? String ?? ""
        options = json["data"] as? [String] ?? []
    }
}
