//
//  FeedImageTableViewCell.swift
//  Gopaddi
//
//  Created by admin on 20/03/24.
//

import UIKit

class FeedImageTableViewCell: UITableViewCell {

   
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
    var isLiked = false

    @IBOutlet weak var firstCommentView: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
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
        
        if let customFont = UIFont(name: "Poppins-Regular.ttf", size: 25.0) {
            // Use customFont with your UI elements
            feedCaption.font = customFont
        } else {
            // Fallback to system font or any other font
        }

        
        
        
        
        print("hi")
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
        print("testView ")
        print("test")
    }
    func makeClickActive(value : Bool){
        saveImgView.isUserInteractionEnabled = value
        commentImgView.isUserInteractionEnabled = value
        shareImgView.isUserInteractionEnabled = value
//        likeImgView.isUserInteractionEnabled = value
    }
    func addGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSaveImg))
        saveImgView.addGestureRecognizer(tapGesture)
        commentImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCommentImg)))
        shareImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapShareImg)))
//        likeImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLikeImg)))
    }
    @objc func didTapSaveImg(){
        actionBlock?()
    }
    @objc func didTapCommentImg(){
        comment?()
    }
//    @objc func didTapLikeImg(){
//        likeAction?()
//        toggleLike()
//    }
    @objc func didTapShareImg(){
        shareAction?()
    }
    @IBAction func didTapPostComment(_ sender: Any) {
        postComment?()
        
    }
    
    
    @IBAction func emojiBtts(_ sender: Any) {
        emojiss?()

    }
    
    
    @IBAction func likereactionshowbtn(_ sender: Any) {
        //likeAction?()
        likeButtonTapped()

       // toggleLike()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
    
    
    @IBAction func likeBtn(_ sender: Any) {
        likeAction?()
        likeButtonTapped()
        
    }
    @objc func likeButtonTapped() {
          // Toggle like button state
          likeBtn.isSelected.toggle()
          
          // Perform animation
          UIView.animate(withDuration: 0.2, animations: {
              // Scale animation
              self.likeBtn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
          }) { _ in
              UIView.animate(withDuration: 0.2) {
                  // Return to original scale
                  self.likeBtn.transform = .identity
              }
          }
      }
    
    func setFirstCommentWithBoldName(comment: String, boldName: String) {
           // Create attributed string for the entire comment
           let attributedString = NSMutableAttributedString(string: comment)
           
           // Find the range of the bold name
           if let range = comment.range(of: boldName) {
               let nsRange = NSRange(range, in: comment)
               
               // Apply bold font to the range of the bold name
               let boldAttributes: [NSAttributedString.Key: Any] = [
                   .font: UIFont.boldSystemFont(ofSize: 14) // Adjust font size as needed
               ]
               attributedString.addAttributes(boldAttributes, range: nsRange)
           }
           
           // Set the attributed string to the label
           firstCommentView.attributedText = attributedString
       }

    
    
//    @objc func likeButtonTapped() {
//          // Toggle like button state
//        likeImgView.isSelected.toggle()
//
//          // Perform animation
//          UIView.animate(withDuration: 0.2, animations: {
//              // Scale animation
//              self.likeImgView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//          }) { _ in
//              UIView.animate(withDuration: 0.2) {
//                  // Return to original scale
//                  self.likeImgView.transform = .identity
//              }
//          }
//      }
    
//    @objc func toggleLike() {
//        isLiked.toggle()
//
//        // Perform animation
//        UIView.animate(withDuration: 0.2, animations: {
//            // Scale animation
//            self.likeImgView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//        }) { _ in
//            UIView.animate(withDuration: 0.2) {
//                // Return to original scale
//                self.likeImgView.transform = .identity
//            }
//        }
//    }


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
extension FeedImageTableViewCell : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        testView.text = ""
    }
}
