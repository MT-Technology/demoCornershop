//
//  ExampleGroupCollectionViewCell.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol ExampleGroupCollectionViewCellProtocol: class {
    
    func exampleGroupCollectionViewCell(cell: ExampleGroupCollectionViewCell, didSelected item: String)
}

class ExampleGroupCollectionViewCell: UICollectionViewCell {

    static let identifier = "ExampleGroupCollectionViewCell"
    static let height: CGFloat = 84.0
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var clvOption: UICollectionView!
    
    private weak var delegate: ExampleGroupCollectionViewCellProtocol?
    private var example : Example?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clvOption.register(UINib(nibName: NibName.Cell.exampleCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ExampleCollectionViewCell.identifier)
    }
    
    func buildCell(example: Example, delegate: ExampleGroupCollectionViewCellProtocol?){
        
        self.example = example
        self.delegate = delegate
        lblTitle.text = example.name.uppercased()
        clvOption.reloadData()
    }
}

extension ExampleGroupCollectionViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        example?.options.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCollectionViewCell.identifier, for: indexPath) as? ExampleCollectionViewCell,
            let option = example?.options[indexPath.row]{
            cell.buildCell(name: option)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ExampleGroupCollectionViewCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let option = example?.options[indexPath.row]{
            delegate?.exampleGroupCollectionViewCell(cell: self, didSelected: option)
        }
    }
}

extension ExampleGroupCollectionViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let name = example?.options[indexPath.row] ?? ""
        let width = name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)]).width + 40
        return CGSize(width: width, height: ExampleCollectionViewCell.height)
    }
}
