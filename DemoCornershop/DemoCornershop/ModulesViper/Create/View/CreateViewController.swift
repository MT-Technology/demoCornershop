//
//  CreateViewController.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol CreateViewProtocol: class {
    
    func stopLoading()
}

class CreateViewController: UIViewController {

    @IBOutlet private weak var txtNameCounter: CornershopTextField!
    @IBOutlet private weak var aivLoading: UIActivityIndicatorView!
    @IBOutlet private weak var lblExample: UILabel!
    
    var presenter: CreatePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupExampleLabel()
        presenter = CreatePresenter(viewController: self)
    }
    
    private func setupExampleLabel(){
        let attr = NSMutableAttributedString(string: "Give it a name. Creative block? See examples.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0, weight: .regular)])
        attr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue , range: attr.mutableString.range(of: "examples", options: .caseInsensitive))
        lblExample.attributedText = attr
        lblExample.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapAction(_:)))
        lblExample.addGestureRecognizer(tap)
    }
    
    private func setupNavigation(){
        title = "Create a counter"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isToolbarHidden = true
        setupNavigationBarButtons()
    }
    
    private func setupNavigationBarButtons(){
        
        let editButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backAction(_:)))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction(_:)))
        saveButton.isEnabled = !(txtNameCounter.text?.isEmpty ?? true)
        navigationItem.leftBarButtonItems = [editButton]
        navigationItem.rightBarButtonItems = [saveButton]
    }
    
    @objc private func backAction(_ sender: UIBarButtonItem){
        presenter?.back()
    }
    
    @objc private func saveAction(_ sender: UIBarButtonItem){
        guard let nameCounter = txtNameCounter.text else {return}
        view.endEditing(true)
        aivLoading.startAnimating()
        presenter?.save(nameCounter: nameCounter)
    }
    
    @objc private func labelTapAction(_ sender: UITapGestureRecognizer){
        presenter?.goToExample()
    }
    
    @IBAction private func tapAction(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction private func textChanged(_ sender: UITextField){
        setupNavigationBarButtons()
    }
}

extension CreateViewController: CreateViewProtocol{
    
    func stopLoading(){
        aivLoading.stopAnimating()
    }
}

extension CreateViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        view.endEditing(true)
        return true
    }
}

extension CreateViewController: ExampleViewDelegate{
    func exampleDidSelected(example: String) {
        txtNameCounter.text = example
        setupNavigationBarButtons()
    }
}

