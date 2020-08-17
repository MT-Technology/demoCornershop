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
            let features = try? JSONDecoder().decode([Feature].self, from: data){
            return features
        }        
        return []
    }
}
