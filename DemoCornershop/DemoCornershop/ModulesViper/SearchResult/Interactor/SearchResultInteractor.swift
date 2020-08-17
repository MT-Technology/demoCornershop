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
    
    func incrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ errorString : String)-> Void)
    func decrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ errorString : String)-> Void)
    
}

class SearchResultInteractor{
    
}

extension SearchResultInteractor: SearchResultInteractorProtocol{
    
    func incrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ errorString : String)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.incrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let data = response.responseData,
                let counters = try? JSONDecoder().decode([Counter].self, from: data),
                let counter = counters.first(where: {$0.id == counterId}){
                success(counter.count)
            }else{
                failure(response.errorMessage)
            }
        }
    }
    
    func decrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ errorString : String)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.decrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let data = response.responseData,
                let counters = try? JSONDecoder().decode([Counter].self, from: data),
                let counter = counters.first(where: {$0.id == counterId}){
                success(counter.count)
            }else{
                failure(response.errorMessage)
            }
        }
    }
}
