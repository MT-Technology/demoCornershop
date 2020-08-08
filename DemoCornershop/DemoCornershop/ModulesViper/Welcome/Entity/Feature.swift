//
//  feature.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation


struct Feature {

    let title: String
    let body: String
    let imageName: String
    let hexaColor: String
    
    init(json: [String:Any]) {
        
        title = json["title"] as? String ?? ""
        body = json["body"] as? String ?? ""
        imageName = json["image"] as? String ?? ""
        hexaColor = json["color"] as? String ?? ""
    }
}
