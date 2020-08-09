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
}
