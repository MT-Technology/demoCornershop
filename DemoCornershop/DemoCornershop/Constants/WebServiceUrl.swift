//
//  WebServiceUrl.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation


struct WebServiceUrl {
    
    private static let baseUrl = "http://localhost:3000/api/v1/"
    
    static let allCounters = WebServiceUrl.baseUrl + "counters"
    
}
