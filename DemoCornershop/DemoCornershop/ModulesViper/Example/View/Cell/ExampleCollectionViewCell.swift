//
//  ExampleCollectionViewCell.swift
//  DemoCornershop
//
//  Created by Everis on 8/9/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

class ExampleCollectionViewCell: UICollectionViewCell {

    static let identifier = "ExampleCollectionViewCell"
    static let height: CGFloat = 50.0
    
    @IBOutlet private weak var lblOption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func buildCell(name: String){
        lblOption.text = name
    }

}
