//
//  FeatureTableViewCell.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblBody: UILabel!
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var imgImage: UIImageView!
    
    
    static let identifier = "FeatureTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buildCell(feature: Feature){
    
        lblTitle.text = feature.title
        lblBody.text = feature.body
        imgImage.image = UIImage(named: feature.imageName)
        viewContent.backgroundColor = UIColor(hex: feature.hexaColor)
    }
}
