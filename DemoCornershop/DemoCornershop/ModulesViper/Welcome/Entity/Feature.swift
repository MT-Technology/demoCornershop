//
//  feature.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

struct Feature: Codable {

    let title: String
    let body: String
    let imageName: String
    let hexaColor: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case imageName = "image"
        case hexaColor = "color"
    }
}
