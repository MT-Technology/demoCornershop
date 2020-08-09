//
//  Counter.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

struct Counter {
    
    let id: String
    var count: Int
    let title: String
    
    init(json: [String:Any]) {
        
        id = json["id"] as? String ?? ""
        count = json["count"] as? Int ?? 0
        title = json["title"] as? String ?? ""
    }
    
    func getTextToShare()->String{
        return "\(count) x \(title)"
    }

}
