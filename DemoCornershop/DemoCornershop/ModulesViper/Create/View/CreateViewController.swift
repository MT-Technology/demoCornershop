//
//  CreateViewController.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol CreateViewProtocol: class {
    
}

class CreateViewController: UIViewController {

    var presenter: CreatePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create a counter"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isToolbarHidden = true
        setupNavigationBarButtons()
        presenter = CreatePresenter(viewController: self)
    }
    
    private func setupNavigationBarButtons(){
        
        let editButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backAction(_:)))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(backAction(_:)))
        saveButton.isEnabled = false
        navigationItem.leftBarButtonItems = [editButton]
        navigationItem.rightBarButtonItems = [saveButton]
    }
    
    @objc private func backAction(_ sender: UIBarButtonItem){
        presenter?.back()
    }
}

extension CreateViewController: CreateViewProtocol{
    
}
