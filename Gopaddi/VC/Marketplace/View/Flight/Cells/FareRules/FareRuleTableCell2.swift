//
//  FareRuleTableCell2.swift
//  Gopaddi
//
//  Created by admin on 13/11/23.
//

import UIKit

class FareRuleTableCell2: UITableViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var airlineLb2: UILabel!
    @IBOutlet weak var aircraft2Lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editViews()
        
    }
    
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
