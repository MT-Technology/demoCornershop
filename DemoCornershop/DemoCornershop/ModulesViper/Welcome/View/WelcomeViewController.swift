//
//  WelcomeViewController.swift
//  DemoCornershop
//
//  Created by Everis on 8/7/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol WelcomeViewProtocol: class{
    
    func reloadData()
}

class WelcomeViewController: UIViewController {

    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var tbvFeatures: UITableView!
    @IBOutlet private weak var btnContinue: UIButton!
    
    private var presenter: WelcomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        tbvFeatures.register(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: FeatureTableViewCell.identifier)
        setTitle()
        presenter = WelcomePresenter(viewController: self)
        presenter?.loadContent()
    }
    
    private func setTitle(){
        
        let attr = NSMutableAttributedString(string: "Welcome to\nCounters",
                                             attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 33.0, weight: .heavy),
                                                          NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "darkYellowCornershop") ?? .black , range: attr.mutableString.range(of: "Counters", options: .caseInsensitive))
        
        lblTitle.attributedText = attr
    }
    
    @IBAction private func btnContinueAction(_ sender: UIButton){
        presenter?.enterToApp()
    }
}

extension WelcomeViewController: WelcomeViewProtocol{
    func reloadData(){
        tbvFeatures.reloadData()
    }
}

extension WelcomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getFeatureCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeatureTableViewCell.identifier, for: indexPath) as? FeatureTableViewCell,
            let feature = presenter?.getFeatureAtIndexPath(indexPath: indexPath){
            
            cell.buildCell(feature: feature)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension WelcomeViewController: UITableViewDelegate{
    
}
