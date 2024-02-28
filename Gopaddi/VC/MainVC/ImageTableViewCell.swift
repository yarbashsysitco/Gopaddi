//
//  ImageTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 06/12/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var shareImgView: UIImageView!
    @IBOutlet weak var commentImgView: UIImageView!
    @IBOutlet weak var likeImgView: UIImageView!
    @IBOutlet weak var saveImgView: UIImageView!
    @IBOutlet weak var us_picture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var feedCreatedDate: UILabel!
    @IBOutlet weak var feedCaption: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedLikeBtn: UIButton!
    @IBOutlet weak var feedLikes: UILabel!
    @IBOutlet weak var feedCommentBtn: UIButton!
    @IBOutlet weak var testView: TextView!
    @IBOutlet weak var feedSaveBtn: UIButton!
    @IBOutlet weak var fePromotion: UIImageView!
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var addCommentsTF: UITextField!
    @IBOutlet weak var feedShare: UILabel!
    @IBOutlet weak var feedSaved: UIButton!
    @IBOutlet weak var feedSaves: UILabel!
    @IBOutlet weak var feedViews: UILabel!
    
    @IBOutlet weak var viewdiaryBtn: UIView!
    
    @IBOutlet weak var emojiBtns: UIButton!
    var popUpButton: (() -> ())?
    var actionBlock: (() -> ())?
    var shareAction : (() -> ())?
    var likeAction : (() -> ())?
    var postComment : (() -> ())?
    var comment : (() -> ())?
    var emojiss : (() -> ())?
    @IBOutlet weak var feedComments: UILabel!
    @IBOutlet weak var textViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var feedComents2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        makeClickActive(value: false)
        addGesture()
        viewdiaryBtn.layer.cornerRadius = 15
        us_picture.layer.masksToBounds = false
        us_picture.layer.borderWidth = 2
        us_picture.layer.borderColor = UIColor.systemGray5.cgColor
        us_picture.layer.cornerRadius = us_picture.frame.height/2
        us_picture.clipsToBounds = true
//        testView.delegate = self
//        testView.text = "Add Comments"
        print("testView.text ")
    }
    func makeClickActive(value : Bool){
        saveImgView.isUserInteractionEnabled = value
        commentImgView.isUserInteractionEnabled = value
        shareImgView.isUserInteractionEnabled = value
        likeImgView.isUserInteractionEnabled = value
    }
    func addGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSaveImg))
        saveImgView.addGestureRecognizer(tapGesture)
        commentImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCommentImg)))
        shareImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapShareImg)))
        likeImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLikeImg)))
    }
    @objc func didTapSaveImg(){
        actionBlock?()
    }
    @objc func didTapCommentImg(){
        comment?()
    }
    @objc func didTapLikeImg(){
        likeAction?()
    }
    @objc func didTapShareImg(){
        shareAction?()
    }
    @IBAction func didTapPostComment(_ sender: Any) {
        postComment?()
        
    }
    
    
    @IBAction func emojiBtts(_ sender: Any) {
        emojiss?()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }

    @IBAction func nepage(_ sender: Any) {
        
//        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SSViewController") as? SSViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
//        
    }
    @IBAction func popUpButtonClicked(_ sender: Any) {
        popUpButton?()
    } 
}
extension ImageTableViewCell : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        testView.text = ""
    }
}
