//
//  ExamplePresenter.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol ExamplePresenterProtocol {
    
    func loadContent()
    func getExampleCount() -> Int
    func getExampleAtIndexPath(indexPath: IndexPath) -> Example
    func back()
}

class ExamplePresenter{
    
    private weak var view: ExampleViewProtocol?
    private var interactor: ExampleInteractorProtocol
    private var router: ExampleRouterProtocol
    
    private var examples: [Example] = []
    
    init(viewController: ExampleViewController){
        view = viewController
        interactor = ExampleInteractor()
        router = ExampleRouter(viewController: viewController)
    }
}

extension ExamplePresenter: ExamplePresenterProtocol{
    
    func loadContent(){
        
        examples = interactor.getExample()
        view?.reloadData()
    }
    
    func getExampleCount() -> Int{
        examples.count
    }
    
    func getExampleAtIndexPath(indexPath: IndexPath) -> Example{
        examples[indexPath.row]
    }
    
    func back(){
        router.back()
    }
}
