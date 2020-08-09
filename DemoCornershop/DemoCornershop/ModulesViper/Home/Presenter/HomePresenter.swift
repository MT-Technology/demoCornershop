//
//  HomePresenter.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol {
    
    func loadCounters()
    func getCounterCount() -> Int
    func getCounterAtIndexPath(indexPath: IndexPath) -> Counter
    func shareCounter(indexPaths: [IndexPath])
}

class HomePresenter{
    
    private weak var view: HomeViewProtocol?
    private var interactor: HomeInteractorProtocol
    private var router: HomeRouterProtocol
    
    private var counters: [Counter] = []
    
    
    init (viewController: HomeViewController){
        self.view = viewController
        self.interactor = HomeInteractor()
        self.router = HomeRouter(viewController: viewController)
    }
}

extension HomePresenter: HomePresenterProtocol{
    
    func loadCounters(){
        
        interactor.getCounters(success: { [weak self] (counters) in
            guard let welf = self else {return}
            welf.counters = counters
            welf.view?.reloadData()
        }) { (error) in
            
        }
    }
    
    func getCounterCount() -> Int{
        counters.count
    }
    
    func getCounterAtIndexPath(indexPath: IndexPath) -> Counter{
        counters[indexPath.row]
    }
    
    func shareCounter(indexPaths: [IndexPath]){
        
        var textArray: [String] = []
        for indexPath in indexPaths{
            textArray.append(counters[indexPath.row].getTextToShare())
        }
        let textToShare = textArray.joined(separator: ", ")
        router.routeToShare(textToShare: textToShare)
    }
}
