//
//  SearchResultInteractor.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import MTWebServiceManager

protocol SearchResultInteractorProtocol {
    
    func incrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void)
    func decrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void)
    
}

class SearchResultInteractor{
    
}

extension SearchResultInteractor: SearchResultInteractorProtocol{
    
    func incrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.incrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let countersUnparsed = response.response as? [[String: Any]],
                let counter = countersUnparsed.map({Counter(json: $0)}).first(where: {$0.id == counterId}){
                success(counter.count)
            }
        }
    }
    
    func decrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.decrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let countersUnparsed = response.response as? [[String: Any]],
                let counter = countersUnparsed.map({Counter(json: $0)}).first(where: {$0.id == counterId}){
                success(counter.count)
            }
        }
    }
}
