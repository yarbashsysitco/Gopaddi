//
//  ChildCountTableViewCell.swift
//  Gopaddi
//
//  Created by Apple on 27/03/24.
//

import UIKit

class ChildCountTableViewCell: UITableViewCell {

    var ageCountBtn : (() -> ())?
    @IBOutlet weak var ageSelectBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var ageShowLbl: UILabel!
    @IBOutlet weak var childCountlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ageSelectionBtn(_ sender: UIButton) {
        ageCountBtn?()
    }
    
}
