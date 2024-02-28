//
//  ProfileInfoTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 01/03/23.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var infoTF: UITextField!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setProfile(info : String , titleData : String){
        infoTF.text = info
        title.text = titleData
    }
    
}
