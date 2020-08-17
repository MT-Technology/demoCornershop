//
//  HomePresenter.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation
import UIKit

protocol HomePresenterProtocol {
    
    func loadCounters()
    func refreshCounters()
    func getCounterCount() -> Int
    func getCounterItemCount() -> Int
    func getCounterAtIndexPath(indexPath: IndexPath) -> Counter
    func shareCounters(indexPaths: [IndexPath])
    func showDeleteAlert(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?)
    func deleteCounters(indexPaths: [IndexPath])
    func deletePersistentCounters(indexPaths: [IndexPath])
    func didIncrementCount(indexPath: IndexPath)
    func didDecrementCount(indexPath: IndexPath)
    func getCounterByFilter(name: String) -> [Counter]
    func createCounter()
}

class HomePresenter{
    
    private weak var view: HomeViewProtocol?
    private var interactor: HomeInteractorProtocol
    private var router: HomeRouterProtocol
    
    private var counters: [Counter] = []
    private var idToDelete: [String] = []
    
    init (viewController: HomeViewController){
        view = viewController
        interactor = HomeInteractor()
        router = HomeRouter(viewController: viewController)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCounterFromResultSearchResult(notification:)),
                                               name: Notification.Name.updateCounterFromSearchResult, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountersAfterCreated(notification:)),
                                               name: NSNotification.Name.updateCountersAfterCreated, object: nil)
    }
    
    @objc private func updateCountersAfterCreated(notification : Notification){
    
        if let counters = notification.object as? [Counter]{
            self.counters = counters
            view?.reloadSection()
        }
    }
    
    @objc private func updateCounterFromResultSearchResult(notification : Notification){
        
        if let counter = notification.object as? Counter,
            let indexRow = counters.firstIndex(where: {$0.id == counter.id}){
            counters[indexRow].count = counter.count
            view?.reloadCell(indexPath: IndexPath(row: indexRow, section: 0))
        }
    }
    
    func deleteCounter(){
        
        if idToDelete.count > 0,
            let counterId = idToDelete.first{
            
            interactor.deleteCounter(counterId: counterId, success: { [weak self] in
                guard let welf = self else {return}
                welf.idToDelete.removeFirst()
                if welf.idToDelete.count == 0{
                    welf.view?.reloadDataAfterRemoveCounter()
                }else{
                    welf.deleteCounter()
                }
            }) { [weak self] (error) in
                
                guard let welf = self else {return}
                welf.router.routeToAlert(title: Message.Alert.Title.errorToDeleteCounter, message: error, retryHandler: { [weak self](action) in
                    self?.deleteCounter()
                }, dismissHandler: nil)
            }
        }
    }
}

extension HomePresenter: HomePresenterProtocol{
    
    func loadCounters(){
        
        if Reachability.isConnectedToNetwork() == false{
            counters.removeAll()
            view?.noInternetConnection()
        }else{
            interactor.getCounters(success: { [weak self] (counters) in
                guard let welf = self else {return}
                welf.counters = counters
                welf.view?.reloadData()
            }) {[weak self] (error)  in
                guard let welf = self else {return}
                welf.router.routeToAlert(title: Message.Alert.Title.errorToLoadCounter, message: error, retryHandler: { [weak self](action) in
                    self?.loadCounters()
                }) { [weak self](action) in
                    self?.view?.stopLoading()
                }
            }
        }
    }
    
    func refreshCounters(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if Reachability.isConnectedToNetwork() == false{
                self.counters.removeAll()
                self.view?.noInternetConnection()
            }else{
                self.interactor.getCounters(success: { [weak self] (counters) in
                    guard let welf = self else {return}
                    welf.counters = counters
                    welf.view?.reloadData()
                }) {[weak self] (error)  in
                    guard let welf = self else {return}
                    welf.view?.stopLoading()
                    welf.router.routeToAlert(title: Message.Alert.Title.errorToLoadCounter, message: error, dismissHandler: nil)
                }
            }
        }
        
    }
    
    func getCounterCount() -> Int{
        counters.count
    }
    
    func getCounterItemCount() -> Int{
        var items = 0
        counters.forEach({items += $0.count})
        return items
    }
    
    func getCounterAtIndexPath(indexPath: IndexPath) -> Counter{
        counters[indexPath.row]
    }
    
    func shareCounters(indexPaths: [IndexPath]){
        
        var textArray: [String] = []
        for indexPath in indexPaths{
            textArray.append(counters[indexPath.row].getTextToShare())
        }
        let textToShare = textArray.joined(separator: ", ")
        router.routeToShare(textToShare: textToShare)
    }
    
    func showDeleteAlert(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?){
        router.routeToDeleteActionSheet(itemsToDelete: itemsToDelete, handler: handler)
    }
    
    func deleteCounters(indexPaths: [IndexPath]){
     
        if Reachability.isConnectedToNetwork() == false{
            router.routeToAlert(title: Message.Alert.Title.errorToDeleteCounter, message: Message.Alert.ErrorMessage.notInternetConnection, dismissHandler: nil)
        }else{
            idToDelete = indexPaths.map({counters[$0.row].id})
            deleteCounter()
        }
    }
    
    func deletePersistentCounters(indexPaths: [IndexPath]){
        
        let rows = indexPaths.map({$0.row}).sorted(by: {$0 > $1})
        rows.forEach({counters.remove(at: $0)})
    }
    
    func didIncrementCount(indexPath: IndexPath){
        
        if Reachability.isConnectedToNetwork() == false{
            
            router.routeToAlert(title: Message.Alert.Title.errorToUpdateCounter(counterName: counters[indexPath.row].title, count: counters[indexPath.row].count + 1), message: Message.Alert.ErrorMessage.notInternetConnection, retryHandler: { [weak self](action) in
                self?.didIncrementCount(indexPath: indexPath)
            }, dismissHandler: nil)
        }else{
            let id = counters[indexPath.row].id
            interactor.incrementCounter(counterId: id, success: { [weak self] counters in
                guard let welf = self else {return}
                welf.counters = counters
                welf.view?.reloadCell(indexPath: indexPath)
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
            interactor.decrementCounter(counterId: id, success: { [weak self] counters in
                guard let welf = self else {return}
                welf.counters = counters
                welf.view?.reloadCell(indexPath: indexPath)
            }){ [weak self] (error) in
                guard let welf = self else {return}
                welf.router.routeToAlert(title: Message.Alert.Title.errorToUpdateCounter(counterName: welf.counters[indexPath.row].title, count: welf.counters[indexPath.row].count - 1), message: error, retryHandler: { [weak self](action) in
                    self?.didDecrementCount(indexPath: indexPath)
                }, dismissHandler: nil)
            }
        }
    }
    
    func getCounterByFilter(name: String) -> [Counter]{
        counters.filter({ $0.title.uppercased().contains(name.uppercased()) })        
    }
    
    func createCounter(){
        router.routeToCreate()
    }
}
