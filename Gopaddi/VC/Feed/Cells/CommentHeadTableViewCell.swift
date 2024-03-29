//
//  CommentHeadTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit
import SDWebImage
import Kingfisher

class CommentHeadTableViewCell: UITableViewCell {

   
    @IBOutlet weak var SaveImg: UIImageView!
    @IBOutlet weak var LikeImg: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedSave: UILabel!
    @IBOutlet weak var feedShare: UILabel!
    @IBOutlet weak var feedLike: UILabel!
    @IBOutlet weak var feedComment: UILabel!
    @IBOutlet weak var profImg: UIImageView!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var profileName: UILabel!
    var popUp : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        profImg.layer.cornerRadius = profImg.frame.width/2
//        profilePic.layer.cornerRadius = profilePic.frame.width/2
       
        // Initialization code
        feedComment.font = UIFont(name: "Poppins-Regular", size: 14)
        feedLike.font = UIFont(name: "Poppins-Regular", size: 14)
        feedShare.font = UIFont(name: "Poppins-Regular", size: 14)
        feedSave.font = UIFont(name: "Poppins-Regular", size: 14)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapPopUp(_ sender: Any) {
        popUp?()
    }
    
    
    func config(profileImg : String, dated: String , caption : String, profName : String, Likes: String, Comment: String, Share: String, Save: String, postImg: String, likeimg: String, saveImg: String){
        captionLbl.text = caption
        postDate.text = dated
        profileName.text = profName
        feedLike.text = Likes
        feedComment.text = Comment
        feedShare.text = Share
        feedSave.text = Save
        profImg.sd_setImage(with: URL(string: profileImg))
        let profilePicUrl = UserDefaults.standard.string(forKey: "picture") ?? ""
        feedImage.kf.setImage(with: URL(string: postImg))
    
        if likeimg == "1"{
            LikeImg.image = UIImage(named: "Heart0")
        }else {
            LikeImg.image = UIImage(named: "Heart1")
        }
        
        if saveImg == "1"{
            SaveImg.image = UIImage(named: "sv1")
        }else{
            SaveImg.image = UIImage(named: "sv0")
        }
    }
}

