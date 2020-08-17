//
//  ExampleViewController.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol ExampleViewDelegate: class{
    func exampleDidSelected(example: String)
}

protocol ExampleViewProtocol: class{
    func reloadData()
}

class ExampleViewController: UIViewController {

    @IBOutlet private weak var clvExample: UICollectionView!
    
    weak var delegate: ExampleViewDelegate?
    private var presenter: ExamplePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clvExample.register(UINib(nibName: NibName.Cell.exampleGroupCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ExampleGroupCollectionViewCell.identifier)
        presenter = ExamplePresenter(viewController: self)
        presenter?.loadContent()
    }
}

extension ExampleViewController: ExampleViewProtocol{
    
    func reloadData(){
        clvExample.reloadData()
    }
}

extension ExampleViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getExampleCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleGroupCollectionViewCell.identifier, for: indexPath) as? ExampleGroupCollectionViewCell,
            let example = presenter?.getExampleAtIndexPath(indexPath: indexPath){
            cell.buildCell(example: example, delegate: self)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ExampleViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ExampleViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width = collectionView.frame.size.width
        return CGSize(width: width, height: ExampleGroupCollectionViewCell.height)
    }
}

extension ExampleViewController: ExampleGroupCollectionViewCellProtocol{
    func exampleGroupCollectionViewCell(cell: ExampleGroupCollectionViewCell, didSelected item: String) {
        
        delegate?.exampleDidSelected(example: item)
        presenter?.back()
    }
}
