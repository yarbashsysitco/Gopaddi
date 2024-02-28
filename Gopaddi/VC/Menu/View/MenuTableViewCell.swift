//
//  MenuTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 09/06/23.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var contenView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = iconView.frame.width/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
