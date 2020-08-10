//
//  CreatePresenter.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol CreatePresenterProtocol: class {
    func back()
    func save(nameCounter: String)
    func goToExample()
}

class CreatePresenter{
    private weak var view: CreateViewProtocol?
    private var interactor: CreateInteractorProtocol
    private var router: CreateRouterProtocol
    
    init(viewController: CreateViewController){
        view = viewController
        interactor = CreateInteractor()
        router = CreateRouter(viewController: viewController)
    }
}

extension CreatePresenter: CreatePresenterProtocol{
    
    func back(){
        router.back()
    }
    
    func save(nameCounter: String){
        
        interactor.createCounter(name: nameCounter, success: { [weak self] (counters) in
            guard let welf = self else {return}
            welf.view?.stopLoading()
            welf.router.routeToConfirmAlert(name: nameCounter)
            NotificationCenter.default.post(name: NSNotification.Name.init("updateCountersAfterCreated"), object: counters)
        }) { (error) in
        }
    }
    
    func goToExample(){
        router.routeToExamples()
    }
}
