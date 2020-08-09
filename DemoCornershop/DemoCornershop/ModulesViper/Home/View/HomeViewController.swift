//
//  HomeViewController.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol HomeViewProtocol: class {
    
    func reloadData()
}

class HomeViewController: UIViewController {

    @IBOutlet private weak var tbvCounter: UITableView!
    
    private var presenter: HomePresenterProtocol?
    lazy private var refreshControl: UIRefreshControl = {
        
        let refresh = UIRefreshControl()
        refresh.backgroundColor = UIColor.clear
        refresh.tintColor = UIColor.black
        refresh.addTarget(self, action: #selector(loadCounters), for: .valueChanged)
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tbvCounter.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: CounterTableViewCell.identifier)
        tbvCounter.refreshControl = refreshControl
        
        setupNavigationController()
        presenter = HomePresenter(viewController: self)
        loadCounters()
    }
    
    private func setupNavigationController(){
        title = "Counters"
        navigationController?.navigationBar.tintColor = UIColor(named: "darkYellowCornershop") ?? .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupNavigationBarButtons()
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = UIColor(named: "darkYellowCornershop") ?? .black
        toolbarItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
                        UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction(_:)))]
    }
    
    private func setupNavigationBarButtons(){
        
        if tbvCounter.isEditing{
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction(_:)))
            navigationItem.leftBarButtonItems = [doneButton]
            
            if let count = presenter?.getCounterCount(),
                let indexPaths = tbvCounter.indexPathsForSelectedRows,
                count == indexPaths.count{
                let deselectAllButton = UIBarButtonItem(title: "Deselect All", style: .plain, target: self, action: #selector(deselectAllAction(_:)))
                navigationItem.rightBarButtonItems = [deselectAllButton]
            }else{
                let selectAllButton = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(selectAllAction(_:)))
                navigationItem.rightBarButtonItems = [selectAllButton]
            }
        }else{
            let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction(_:)))
            navigationItem.leftBarButtonItems = [editButton]
            navigationItem.rightBarButtonItems = []
            
        }
        
    }
    
    private func setupToolbar(){
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = UIColor(named: "darkYellowCornershop") ?? .black
        setupToolbarBarButtons()
    }
    private func setupToolbarBarButtons(){
        
        if tbvCounter.isEditing{
            
            let deleteButton =  UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(addAction(_:)))
            let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction(_:)))
            toolbarItems = [deleteButton,
                            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
                            shareButton]
            
            if tbvCounter.indexPathsForSelectedRows == nil{
                deleteButton.isEnabled = false
                shareButton.isEnabled = false
            }else{
                deleteButton.isEnabled = true
                shareButton.isEnabled = true
            }
            
        }else{
            toolbarItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
                            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction(_:)))]

        }
    }
    
    @objc private func doneAction(_ sender: UIBarButtonItem){
        print("echo")
        tbvCounter.isEditing = false
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func selectAllAction(_ sender: UIBarButtonItem){
        print("select all")
        
        if let count = presenter?.getCounterCount(){
            for row in 0..<count{
                tbvCounter.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
            }
        }
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func deselectAllAction(_ sender: UIBarButtonItem){
        print("deselect all")
        
        if let count = presenter?.getCounterCount(){
            for row in 0..<count{
                tbvCounter.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
            }
        }
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func editAction(_ sender: UIBarButtonItem){
        print("editar")
        tbvCounter.isEditing = true
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func addAction(_ sender: UIBarButtonItem){
        print("agregar")
    }
    
    @objc private func shareAction(_ sender: UIBarButtonItem){
        print("share")
        if let indexPaths = tbvCounter.indexPathsForSelectedRows{
            presenter?.shareCounter(indexPaths: indexPaths)
        }
    }

    @objc private func loadCounters(){
        presenter?.loadCounters()
    }
    
}

extension HomeViewController: HomeViewProtocol{
    
    func reloadData(){
        refreshControl.endRefreshing()
        tbvCounter.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCounterCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CounterTableViewCell.identifier, for: indexPath) as? CounterTableViewCell,
            let counter = presenter?.getCounterAtIndexPath(indexPath: indexPath){
            cell.buildCell(counter: counter)
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension HomeViewController: UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing{
            if let count = presenter?.getCounterCount(),
                let indexPaths = tableView.indexPathsForSelectedRows,
                count == indexPaths.count{
                setupNavigationBarButtons()
            }
            setupToolbarBarButtons()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing{
            if tableView.indexPathsForSelectedRows == nil{
                setupNavigationBarButtons()
            }
            setupToolbarBarButtons()
        }
    }
}
