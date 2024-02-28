//
//  ProfileCell.swift
//  Gopaddi
//
//  Created by admin on 04/01/23.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var testView: UITextView!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var saveCount: UILabel!
    @IBOutlet weak var shareCount: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var feedImgView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func didTapShare(_ sender: Any) {
    }
    
    @IBAction func didTapLike(_ sender: Any) {
    }
    @IBAction func didTapComment(_ sender: Any) {
    }
    
    @IBAction func didTapPost(_ sender: Any) {
    }
    @IBAction func didTapSave(_ sender: Any) {
    }
}
