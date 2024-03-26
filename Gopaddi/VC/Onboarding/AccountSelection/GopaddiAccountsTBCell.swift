//
//  GopaddiAccountsTBCell.swift
//  Gopaddisubdemo
//
//  Created by Apple on 20/03/24.
//

import UIKit

class GopaddiAccountsTBCell: UITableViewCell {

   
    @IBOutlet weak var radioBtnImage: UIImageView!
    @IBOutlet weak var AccountView: MyView!
    @IBOutlet weak var accountDescription: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountImages: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
