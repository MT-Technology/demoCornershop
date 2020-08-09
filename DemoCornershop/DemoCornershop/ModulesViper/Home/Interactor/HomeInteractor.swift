//
//  HomeInteractor.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import MTWebServiceManager

protocol HomeInteractorProtocol {
    
    func getCounters(success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ error : Error)-> Void)
    func deleteCounter(counterId: String, success: @escaping ()-> Void, failure: @escaping (_ error : Error)-> Void)
}

class HomeInteractor{
    
}

extension HomeInteractor: HomeInteractorProtocol{
    
    func getCounters(success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ error : Error)-> Void){
        
       MTWebServiceManager.shared.request.getRequest(urlString: WebServiceUrl.allCounters, parameters: nil) { (response) in
            
            if response.status == .success,
                let countersUnparsed = response.response as? [[String: Any]]{
                success(countersUnparsed.map({Counter(json: $0)}))
            }else{
                
            }
        }
    }
    
    func deleteCounter(counterId: String, success: @escaping ()-> Void, failure: @escaping (_ error : Error)-> Void){
        
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.deleteRequest(urlString: WebServiceUrl.deleteCounter, parameters: param) { (response) in
            if response.status == .success{
                success()
            }
        }
    }
}
