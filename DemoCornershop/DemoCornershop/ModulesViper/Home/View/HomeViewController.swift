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
    func stopLoading()
    func reloadDataAfterRemoveCounter()
    func reloadCell(indexPath: IndexPath)
    func reloadSection()
    func noInternetConnection()
}

class HomeViewController: UIViewController {

    @IBOutlet private weak var tbvCounter: UITableView!
    @IBOutlet private weak var aivLoading: UIActivityIndicatorView!
    
    @IBOutlet private weak var noDataView: UIView!
    @IBOutlet private weak var noNetworkView: UIView!
    
    private var presenter: HomePresenterProtocol?
    lazy private var refreshControl: UIRefreshControl = {
        
        let refresh = UIRefreshControl()
        refresh.backgroundColor = UIColor.clear
        refresh.tintColor = UIColor.black
        refresh.addTarget(self, action: #selector(refreshCounters), for: .valueChanged)
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tbvCounter.register(UINib(nibName: NibName.Cell.counterTableViewCell, bundle: nil), forCellReuseIdentifier: CounterTableViewCell.identifier)
        tbvCounter.refreshControl = refreshControl
        setupNavigationController()
        setupSearchBar()
        presenter = HomePresenter(viewController: self)
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolbar()
    }
    
    private func setupNavigationController(){
        title = Message.Home.title
        navigationController?.navigationBar.tintColor = Color.darkYellow
        navigationController?.navigationBar.isHidden = false
        setupNavigationBarButtons()
    }
    
    private func setupSearchBar(){
        
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.isUserInteractionEnabled = (presenter?.getCounterCount() ?? 0) > 0
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupNavigationBarButtons(){
        
        if tbvCounter.isEditing{
            let doneButton = UIBarButtonItem(title: Message.Home.BarButtonText.done, style: .plain, target: self, action: #selector(doneAction(_:)))
            navigationItem.leftBarButtonItems = [doneButton]
            
            if let count = presenter?.getCounterCount(),
                let indexPaths = tbvCounter.indexPathsForSelectedRows,
                count == indexPaths.count{
                let deselectAllButton = UIBarButtonItem(title: Message.Home.BarButtonText.deselectAll, style: .plain, target: self, action: #selector(deselectAllAction(_:)))
                navigationItem.rightBarButtonItems = [deselectAllButton]
            }else{
                let selectAllButton = UIBarButtonItem(title: Message.Home.BarButtonText.selectAll, style: .plain, target: self, action: #selector(selectAllAction(_:)))
                navigationItem.rightBarButtonItems = [selectAllButton]
            }
        }else{
            let count = presenter?.getCounterCount() ?? 0
            let editButton = UIBarButtonItem(title: Message.Home.BarButtonText.edit, style: .plain, target: self, action: #selector(editAction(_:)))
            editButton.isEnabled = count > 0
            navigationItem.leftBarButtonItems = [editButton]
            navigationItem.rightBarButtonItems = []
        }
    }
    
    private func setupToolbar(){
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = Color.darkYellow
        setupToolbarBarButtons()
    }
    private func setupToolbarBarButtons(){
        
        if tbvCounter.isEditing{
            
            let deleteButton =  UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction(_:)))
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
            if let count = presenter?.getCounterCount(),
                count > 0,
                let times = presenter?.getCounterItemCount(){
                
                let label = UILabel()
                label.text = Message.Home.footerTitle(numberOfItems: count, nomberOfCounts: times)
                label.font = Font.SFProDisplay.Medium._15
                label.textColor = Color.darkGray
                
                toolbarItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
                                UIBarButtonItem(customView: label),
                                UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
                                UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction(_:)))]
                
            }else{
                toolbarItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
                                UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction(_:)))]
            }
        }
    }
    
    private func setupInteractiveView(){
        tbvCounter.isUserInteractionEnabled = (presenter?.getCounterCount() ?? 0) != 0
        noDataView.isHidden = (presenter?.getCounterCount() ?? 0) != 0
    }
    
    private func load(){
        tbvCounter.isUserInteractionEnabled = false
        noNetworkView.isHidden = true
        noDataView.isHidden = true
        aivLoading.startAnimating()
        presenter?.loadCounters()
    }
    
    @objc private func doneAction(_ sender: UIBarButtonItem){
        tbvCounter.setEditing(false, animated: true)
        navigationItem.searchController?.searchBar.isUserInteractionEnabled = true
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func selectAllAction(_ sender: UIBarButtonItem){
        if let count = presenter?.getCounterCount(){
            for row in 0..<count{
                tbvCounter.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
            }
        }
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func deselectAllAction(_ sender: UIBarButtonItem){
        if let count = presenter?.getCounterCount(){
            for row in 0..<count{
                tbvCounter.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
            }
        }
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func editAction(_ sender: UIBarButtonItem){
        tbvCounter.setEditing(true, animated: true)
        navigationItem.searchController?.searchBar.isUserInteractionEnabled = false
        setupNavigationBarButtons()
        setupToolbarBarButtons()
    }
    
    @objc private func addAction(_ sender: UIBarButtonItem){
        presenter?.createCounter()
    }
    
    @objc private func shareAction(_ sender: UIBarButtonItem){
        if let indexPaths = tbvCounter.indexPathsForSelectedRows{
            presenter?.shareCounters(indexPaths: indexPaths)
        }
    }
    
    @objc private func deleteAction(_ sender: UIBarButtonItem){
        
        if let indexPaths = tbvCounter.indexPathsForSelectedRows{
            
            let handler: ((UIAlertAction) -> Void) = {[weak self] action in
                guard let welf = self else {return}
                welf.presenter?.deleteCounters(indexPaths: indexPaths)
            }
            
            presenter?.showDeleteAlert(itemsToDelete: indexPaths.count, handler: handler)
        }
    }

    @objc private func refreshCounters(){
        presenter?.refreshCounters()
    }
    
    @IBAction private func createCounterAction(_ sender: UIButton){
        presenter?.createCounter()
    }
    
    @IBAction private func retryAction(_ sender: UIButton){
        load()
    }
}

extension HomeViewController: HomeViewProtocol{
    
    func reloadData(){
        stopLoading()
        setupInteractiveView()
    }
    
    func stopLoading(){
        aivLoading.stopAnimating()
        refreshControl.endRefreshing()
        tbvCounter.reloadData()
        setupNavigationBarButtons()
        setupToolbarBarButtons()
        setupSearchBar()
    }
    
    func reloadDataAfterRemoveCounter(){
        
        if let indexPaths = tbvCounter.indexPathsForSelectedRows{
            
            presenter?.deletePersistentCounters(indexPaths: indexPaths)
            tbvCounter.performBatchUpdates({
                tbvCounter.deleteRows(at: indexPaths, with: .left)
            }, completion: nil)
            tbvCounter.setEditing(false, animated: true)
            setupNavigationBarButtons()
            setupToolbarBarButtons()
            setupSearchBar()
            setupInteractiveView()
        }
    }
    
    func reloadCell(indexPath: IndexPath){
        
        tbvCounter.reloadRows(at: [indexPath], with: .none)
        setupToolbarBarButtons()
    }
    
    func reloadSection(){
        
        tbvCounter.reloadSections(IndexSet(integer: 0), with: .none)
        setupNavigationBarButtons()
        setupToolbarBarButtons()
        setupSearchBar()
        setupInteractiveView()
    }
    
    func noInternetConnection(){
        refreshControl.endRefreshing()
        aivLoading.stopAnimating()
        noDataView.isHidden = true
        noNetworkView.isHidden = false
        tbvCounter.reloadData()
        setupNavigationBarButtons()
        setupToolbarBarButtons()
        setupSearchBar()
    }
}

extension HomeViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let vc = searchController.searchResultsController as? SearchResultViewController,
            let searchText = searchController.searchBar.text,
            let counters = presenter?.getCounterByFilter(name: searchText){
            vc.setFilterResult(counters: counters)
        }
    }
}

extension HomeViewController: UISearchControllerDelegate{
    
    func willPresentSearchController(_ searchController: UISearchController) {
        navigationController?.toolbar.isHidden = true
    }
    
    func willDismissSearchController(_ searchController: UISearchController){
        navigationController?.toolbar.isHidden = false
    }
    
}

extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCounterCount() ?? 0
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

extension HomeViewController: CounterTableViewCellProtocol{
    
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
