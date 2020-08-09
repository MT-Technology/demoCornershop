//
//  CounterTableViewCell.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

class CounterTableViewCell: UITableViewCell {

    static let identifier = "CounterTableViewCell"
    
    @IBOutlet private weak var lblCount: UILabel!
    @IBOutlet private weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let viewForHighlight = UIView()
        selectedBackgroundView = viewForHighlight
        viewForHighlight.backgroundColor = UIColor.clear
    }
    
    func buildCell(counter: Counter){
        
        lblCount.text = "\(counter.count)"
        lblTitle.text = counter.title
        
    }
}
