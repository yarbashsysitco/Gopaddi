//
//  BaggagInfoTableCell2.swift
//  Gopaddi
//
//  Created by admin on 13/11/23.
//

import UIKit

class BaggagInfoTableCell2: UITableViewCell {

    @IBOutlet weak var fromLb: UILabel!
    @IBOutlet weak var toLb: UILabel!
    
    @IBOutlet weak var weightLb2: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
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
