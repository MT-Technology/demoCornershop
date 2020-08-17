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
        
        if Reachability.isConnectedToNetwork() == false{
            view?.stopLoading()
            router.routeToAlert(title: Message.Alert.Title.errorToCreateCounter, message: Message.Alert.ErrorMessage.notInternetConnection, retryHandler: { [weak self](action) in
                self?.save(nameCounter: nameCounter)
            }, dismissHandler: nil)
        }else{
            interactor.createCounter(name: nameCounter, success: { [weak self] (counters) in
                guard let welf = self else {return}
                welf.view?.stopLoading()
                welf.router.routeToAlert(title: Message.Alert.Title.appName, message: Message.Alert.ErrorMessage.createCounterSuccess(name: nameCounter)) { [weak self] (action) in
                    self?.back()
                }
                NotificationCenter.default.post(name: NSNotification.Name.updateCountersAfterCreated, object: counters)
            }) { [weak self] (error) in
                guard let welf = self else {return}
                welf.router.routeToAlert(title: Message.Alert.Title.errorToCreateCounter, message: error, retryHandler: { [weak self](action) in
                    self?.save(nameCounter: nameCounter)
                }) { [weak self] (action) in
                    self?.view?.stopLoading()
                }
            }
        }
    }
    
    func goToExample(){
        router.routeToExamples()
    }
}
