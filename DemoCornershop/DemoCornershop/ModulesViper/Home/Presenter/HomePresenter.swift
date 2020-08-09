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
    func getCounterCount() -> Int
    func getCounterAtIndexPath(indexPath: IndexPath) -> Counter
    func shareCounters(indexPaths: [IndexPath])
    func showDeleteAlert(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?)
    func deleteCounters(indexPaths: [IndexPath])
    func deletePersistentCounters(indexPaths: [IndexPath])
}

class HomePresenter{
    
    private weak var view: HomeViewProtocol?
    private var interactor: HomeInteractorProtocol
    private var router: HomeRouterProtocol
    
    private var counters: [Counter] = []
    private var idToDelete: [String] = []
    
    init (viewController: HomeViewController){
        self.view = viewController
        self.interactor = HomeInteractor()
        self.router = HomeRouter(viewController: viewController)
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
            }) { (error) in
                
            }
        }
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
    
    func shareCounters(indexPaths: [IndexPath]){
        
        var textArray: [String] = []
        for indexPath in indexPaths{
            textArray.append(counters[indexPath.row].getTextToShare())
        }
        let textToShare = textArray.joined(separator: ", ")
        router.routeToShare(textToShare: textToShare)
    }
    
    func showDeleteAlert(itemsToDelete: Int, handler: ((UIAlertAction) -> Void)?){
        router.routeToDeleteAlert(itemsToDelete: itemsToDelete, handler: handler)
    }
    
    func deleteCounters(indexPaths: [IndexPath]){
     
        idToDelete = indexPaths.map({counters[$0.row].id})
        deleteCounter()
    }
    
    func deletePersistentCounters(indexPaths: [IndexPath]){
        
        let rows = indexPaths.map({$0.row}).sorted(by: {$0 > $1})
        rows.forEach({counters.remove(at: $0)})
    }
}
