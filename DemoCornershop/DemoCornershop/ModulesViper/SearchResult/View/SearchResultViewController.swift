//
//  SearchResultViewController.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol SearchResultViewProtocol: class {
    
    func reloadCell(indexPath: IndexPath)
}

class SearchResultViewController: UIViewController {

    @IBOutlet private weak var tbvCounter: UITableView!
    
    private var presenter: SearchResultPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tbvCounter.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: CounterTableViewCell.identifier)
        presenter = SearchResultPresenter(viewController: self)
    }
    
    func setFilterResult(counters : [Counter]){
        presenter?.setFilterResult(counters: counters)
        tbvCounter.reloadData()
    }
}

extension SearchResultViewController: SearchResultViewProtocol{
    
    func reloadCell(indexPath: IndexPath){
        tbvCounter.reloadRows(at: [indexPath], with: .none)
    }
}

extension SearchResultViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCounterCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CounterTableViewCell.identifier, for: indexPath) as? CounterTableViewCell,
            let counter = presenter?.getCounterAtIndexPath(indexPath: indexPath){
            cell.buildCell(counter: counter, delegate: self)
            return cell
        }
        return UITableViewCell()
    }
}

extension SearchResultViewController: CounterTableViewCellProtocol{
    
    func didDecrementCount(cell: CounterTableViewCell) {
        if let indexPath = tbvCounter.indexPath(for: cell){
            presenter?.didDecrementCount(indexPath: indexPath)
        }
    }
    
    func didIncrementCount(cell: CounterTableViewCell) {
        if let indexPath = tbvCounter.indexPath(for: cell){
            presenter?.didIncrementCount(indexPath: indexPath)
        }
    }
}