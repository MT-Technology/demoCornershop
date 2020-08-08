//
//  WelcomeInteractor.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol WelcomeInteractorProtocol: class{
    
    func getFeatures() -> [Feature]
}

class WelcomeInteractor{
    
}

extension WelcomeInteractor: WelcomeInteractorProtocol{
    
    func getFeatures() -> [Feature]{
        
        if let path = Bundle.main.path(forResource: "features", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any],
            let featuresUnparsed = jsonResult["data"] as? [[String:Any]]{
        
            let features : [Feature] = featuresUnparsed.map({Feature(json: $0)})
            return features
        }
        
        return []
    }
}
