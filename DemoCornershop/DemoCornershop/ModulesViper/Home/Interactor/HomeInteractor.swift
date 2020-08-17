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
    
    func getCounters(success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void)
    func deleteCounter(counterId: String, success: @escaping ()-> Void, failure: @escaping (_ errorMessage : String)-> Void)
    func incrementCounter(counterId: String, success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void)
    func decrementCounter(counterId: String, success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void)
}

class HomeInteractor{
}

extension HomeInteractor: HomeInteractorProtocol{
    
    func getCounters(success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void){
        MTWebServiceManager.shared.request.getRequest(urlString: WebServiceUrl.allCounters, parameters: nil) { (response) in
            if response.status == .success,
                let data = response.responseData,
                let counters = try? JSONDecoder().decode([Counter].self, from: data){
                success(counters)
            }else{
                failure(response.errorMessage)
            }
        }
    }
    
    func deleteCounter(counterId: String, success: @escaping ()-> Void, failure: @escaping (_ errorMessage : String)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.deleteRequest(urlString: WebServiceUrl.deleteCounter, parameters: param) { (response) in
            if response.status == .success{
                success()
            }else{
                failure(response.errorMessage)
            }
        }
    }
    
    func incrementCounter(counterId: String, success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.incrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let data = response.responseData,
                let counters = try? JSONDecoder().decode([Counter].self, from: data){
                success(counters)
            }else{
                failure(response.errorMessage)
            }
        }
    }
    
    func decrementCounter(counterId: String, success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void){
        let param = ["id": counterId]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.decrementCounter, parameters: param) { (response) in
            if response.status == .success,
                let data = response.responseData,
                let counters = try? JSONDecoder().decode([Counter].self, from: data){
                success(counters)
            }else{
                failure(response.errorMessage)
            }
        }
    }
}
