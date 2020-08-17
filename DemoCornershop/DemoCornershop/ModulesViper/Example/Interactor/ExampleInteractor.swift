//
//  ExampleInteractor.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol ExampleInteractorProtocol{
    
    func getExample() -> [Example]
}

class ExampleInteractor{
    
}

extension ExampleInteractor: ExampleInteractorProtocol{
    
    func getExample() -> [Example]{
        
        if let path = Bundle.main.path(forResource: "example", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let examples = try? JSONDecoder().decode([Example].self, from: data){
            return examples
        }
        return []
    }
}
