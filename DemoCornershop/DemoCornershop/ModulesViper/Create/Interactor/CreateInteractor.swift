//
//  CreateInteractor.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import MTWebServiceManager

protocol CreateInteractorProtocol : class{
    
    func createCounter(name: String, success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void)
}

class CreateInteractor{
    
    
}

extension CreateInteractor: CreateInteractorProtocol{

    func createCounter(name: String, success: @escaping (_ counters: [Counter])-> Void, failure: @escaping (_ errorMessage : String)-> Void){
        
        let param = ["title" : name]
        MTWebServiceManager.shared.request.postRequest(urlString: WebServiceUrl.createCounter, parameters: param) { (response) in
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
