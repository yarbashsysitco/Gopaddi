//
//  SettingsTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 01/03/23.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(with setting : SettingsHead){
        titleLbl.text = setting.title
        iconImage.image = setting.icon.withTintColor(.label, renderingMode: .alwaysTemplate)
    }

}
