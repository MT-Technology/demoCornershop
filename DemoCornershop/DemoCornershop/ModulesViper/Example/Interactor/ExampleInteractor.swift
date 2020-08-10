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
            let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any],
            let exampleUnparsed = jsonResult["data"] as? [[String:Any]]{
            let examples : [Example] = exampleUnparsed.map({Example(json: $0)})
            return examples
        }
        
        return []
    }
}
