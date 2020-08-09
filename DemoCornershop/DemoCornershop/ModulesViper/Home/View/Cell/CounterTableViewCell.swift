//
//  CounterTableViewCell.swift
//  DemoCornershop
//
//  Created by Everis on 8/8/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import UIKit

protocol CounterTableViewCellProtocol: class {
    
    func didIncrementCount(cell: CounterTableViewCell)
    
    func didDecrementCount(cell: CounterTableViewCell)
}

class CounterTableViewCell: UITableViewCell {

    static let identifier = "CounterTableViewCell"
    
    @IBOutlet private weak var lblCount: UILabel!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var stpCount: UIStepper!
    private weak var delegate: CounterTableViewCellProtocol?
    private var count: Int = 0
    
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
    
    func buildCell(counter: Counter, delegate: CounterTableViewCellProtocol?){
        
        self.delegate = delegate
        lblCount.text = "\(counter.count)"
        lblTitle.text = counter.title
        stpCount.value = Double(counter.count)
        count = counter.count
        lblCount.textColor = count == 0 ? UIColor(named: "grayCornershop") : UIColor(named: "darkYellowCornershop")
    }
    
    @IBAction private func countChangedAction(_ sender: UIStepper){
        
        let newCount = Int(sender.value)
        if count < newCount &&
            newCount < 100{
            delegate?.didIncrementCount(cell: self)
        }else if count > newCount{
            delegate?.didDecrementCount(cell: self)
        }
    }
}
