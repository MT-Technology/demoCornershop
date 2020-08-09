//
//  SearchResultPresenter.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation

protocol SearchResultPresenterProtocol: class{
 
    func setFilterResult(counters: [Counter])
    func getCounterCount() -> Int
    func getCounterAtIndexPath(indexPath: IndexPath) -> Counter
    func didIncrementCount(indexPath: IndexPath)
    func didDecrementCount(indexPath: IndexPath)
}

class SearchResultPresenter{
    
    private weak var view: SearchResultViewProtocol?
    private var interactor: SearchResultInteractorProtocol
    private var counters : [Counter] = []
    
    init(viewController: SearchResultViewController) {
        view = viewController
        interactor = SearchResultInteractor()
    }
    
}

extension SearchResultPresenter: SearchResultPresenterProtocol{
    
    func setFilterResult(counters: [Counter]){
        self.counters = counters
    }
    
    func getCounterCount() -> Int{
        counters.count
    }
    
    func getCounterAtIndexPath(indexPath: IndexPath) -> Counter{
        counters[indexPath.row]
    }
    
    func didIncrementCount(indexPath: IndexPath){
        let id = counters[indexPath.row].id
        interactor.incrementCounter(counterId: id, success: { [weak self] count in
            guard let welf = self else {return}
            welf.counters[indexPath.row].count = count
            welf.view?.reloadCell(indexPath: indexPath)
            NotificationCenter.default.post(name: NSNotification.Name.init("updateCounterFromSearchResult"),
                                            object: welf.counters[indexPath.row])
        }) { (error) in
        }
    }
    
    func didDecrementCount(indexPath: IndexPath){
        let id = counters[indexPath.row].id
        interactor.decrementCounter(counterId: id, success: { [weak self] count in
            guard let welf = self else {return}
            welf.counters[indexPath.row].count = count
            welf.view?.reloadCell(indexPath: indexPath)
            NotificationCenter.default.post(name: NSNotification.Name.init("updateCounterFromSearchResult"),
                                            object: welf.counters[indexPath.row])
        }) { (error) in
        }
    }
}
