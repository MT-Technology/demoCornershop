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
    func incrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void)
    func decrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void)
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
    
    func incrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.incrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let dictArray = response.response as? [[String:Any]],
                let dict = dictArray.first{
                var count = dict["count"] as? Int ?? 0
                if count < 0{count = 0}
                if count > 99{count = 99}
                success(count)
            }
        }
    }
    
    func decrementCounter(counterId: String, success: @escaping (_ count: Int)-> Void, failure: @escaping (_ error : Error)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.decrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let dictArray = response.response as? [[String:Any]],
                let dict = dictArray.first{
                var count = dict["count"] as? Int ?? 0
                if count < 0{count = 0}
                if count > 99{count = 99}
                success(count)
            }
        }
    }
}
