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
    private var router: SearchResultRouterProtocol
    private var counters : [Counter] = []
    
    init(viewController: SearchResultViewController) {
        view = viewController
        interactor = SearchResultInteractor()
        router = SearchResultRouter(viewController: viewController)
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
        
        if Reachability.isConnectedToNetwork() == false{
            
            router.routeToAlert(title: Message.Alert.Title.errorToUpdateCounter(counterName: counters[indexPath.row].title, count: counters[indexPath.row].count + 1), message: Message.Alert.ErrorMessage.notInternetConnection, retryHandler: { [weak self](action) in
                self?.didIncrementCount(indexPath: indexPath)
            }, dismissHandler: nil)
        }else{
            let id = counters[indexPath.row].id
            interactor.incrementCounter(counterId: id, success: { [weak self] count in
                guard let welf = self else {return}
                welf.counters[indexPath.row].count = count
                welf.view?.reloadCell(indexPath: indexPath)
                NotificationCenter.default.post(name: NSNotification.Name.updateCounterFromSearchResult,
                                                object: welf.counters[indexPath.row])
            }) { [weak self] (error) in
                guard let welf = self else {return}
                welf.router.routeToAlert(title: Message.Alert.Title.errorToUpdateCounter(counterName: welf.counters[indexPath.row].title, count: welf.counters[indexPath.row].count + 1), message: error, retryHandler: { [weak self](action) in
                    self?.didIncrementCount(indexPath: indexPath)
                }, dismissHandler: nil)
            }
        }
    }
    
    func didDecrementCount(indexPath: IndexPath){
        
        if Reachability.isConnectedToNetwork() == false{
            
            router.routeToAlert(title: Message.Alert.Title.errorToUpdateCounter(counterName: counters[indexPath.row].title, count: counters[indexPath.row].count - 1), message: Message.Alert.ErrorMessage.notInternetConnection, retryHandler: { [weak self](action) in
                self?.didDecrementCount(indexPath: indexPath)
            }, dismissHandler: nil)
        }else{
            
            let id = counters[indexPath.row].id
            interactor.decrementCounter(counterId: id, success: { [weak self] count in
                guard let welf = self else {return}
                welf.counters[indexPath.row].count = count
                welf.view?.reloadCell(indexPath: indexPath)
                NotificationCenter.default.post(name: NSNotification.Name.updateCounterFromSearchResult,
                                                object: welf.counters[indexPath.row])
            }) { [weak self] (error) in
                guard let welf = self else {return}
                welf.router.routeToAlert(title: Message.Alert.Title.errorToUpdateCounter(counterName: welf.counters[indexPath.row].title, count: welf.counters[indexPath.row].count - 1), message: error, retryHandler: { [weak self](action) in
                    self?.didDecrementCount(indexPath: indexPath)
                }, dismissHandler: nil)
            }
        }
    }
}
