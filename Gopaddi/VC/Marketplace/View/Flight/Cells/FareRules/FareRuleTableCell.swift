//
//  FareRuleTableCell.swift
//  Gopaddi
//
//  Created by admin on 13/11/23.
//

import UIKit

class FareRuleTableCell: UITableViewCell {

    @IBOutlet weak var airlineLb: UILabel!
    @IBOutlet weak var aircraftLb: UILabel!
    
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        editViews()     }
    
    func applyStyles(to view: UIView) {
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
    }
    
    func editViews() {
        
        applyStyles(to: backView)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
