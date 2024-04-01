//
//  FeedImageTableViewCell.swift
//  Gopaddi
//
//  Created by admin on 20/03/24.
//

import UIKit
import SkeletonView

class FeedImageTableViewCell: UITableViewCell{
   
    

   
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

    @IBOutlet weak var seemoreBtn: UIButton!
    @IBOutlet weak var firstCommentView: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var viewdiaryBtn: UIView!
    
    @IBOutlet weak var animastionHeart: UIImageView!
    @IBOutlet weak var emojiBtns: UIButton!
    var popUpButton: (() -> ())?
    var actionBlock: (() -> ())?
    var shareAction : (() -> ())?
    var likeAction : (() -> ())?
    var postComment : (() -> ())?
    var comment : (() -> ())?
    var emojiss : (() -> ())?
    var seemores : (() -> ())?
    var emojiCountbtn : (() -> ())?
    @IBOutlet weak var feedComments: UILabel!
    @IBOutlet weak var textViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var feedComents2: UILabel!
    var postImageData: [PostFile]?
    
    @IBOutlet weak var FeedImageCollectionCell: UICollectionView!
    
    @IBOutlet weak var imageCelllSize: NSLayoutConstraint!
    
    var postFile: [PostFile]?
    let apiManager = ApiManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        print("hello")
        
        FeedImageCollectionCell.delegate = self
        FeedImageCollectionCell.dataSource = self

               // Register collection view cell
        FeedImageCollectionCell.register(UINib(nibName: "FeedImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedImageCollectionViewCell")
        
        // Set custom layout
          let layout = FirstItemVisibleLayout()
          layout.scrollDirection = .horizontal
          FeedImageCollectionCell.collectionViewLayout = layout
        
//        self.FeedImageCollectionCell.register(UINib.init(nibName: "FeedImageCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FeedImageCollectionViewCell")
//        
        animastionHeart.isHidden = true
        if let customFont = UIFont(name: "Poppins-Regular.ttf", size: 25.0) {
            // Use customFont with your UI elements
            feedCaption.font = customFont
        } else {
            // Fallback to system font or any other font
        }

        feedCaption.numberOfLines = 2

        if let flowLayout = FeedImageCollectionCell.collectionViewLayout as? UICollectionViewFlowLayout {
                   flowLayout.scrollDirection = .horizontal
                   flowLayout.minimumLineSpacing = 0
                   flowLayout.minimumInteritemSpacing = 0
                   flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
               }

               // Enable paging
        FeedImageCollectionCell.isPagingEnabled = true
        
        
        print("hi")
        makeClickActive(value: false)
        addGesture()
//        viewdiaryBtn.layer.cornerRadius = 15
        us_picture.layer.masksToBounds = false
        us_picture.layer.borderWidth = 2
        us_picture.layer.borderColor = UIColor.systemGray5.cgColor
        us_picture.layer.cornerRadius = us_picture.frame.height/2
        us_picture.clipsToBounds = true
//        testView.delegate = self
//        testView.text = "Add Comments"
        print("testView ")
        print("test")
        //callFeeds2()
        self.FeedImageCollectionCell.reloadData()

    }
    
//    func callFeeds2() {
//           self.apiManager.getPostBody { result in
//               switch result {
//               case .success(let model):
//                   DispatchQueue.main.async {
//                       
////                       self.imageCelllSize.constant = 1
//                       // Extract files from the first post
//                       self.postImageData = model.data?.first?.posts.compactMap { $0.files }.flatMap { $0 }
//                       // Reload collection view data after fetching postFiles
//                       print("POOO:\(self.postFile)")
//                       self.FeedImageCollectionCell.reloadData()
//                   }
//               case .failure(let error):
//                   print(error.localizedDescription)
//               }
//           }
//       }
    
//    if let posts = self.postFile {
//        for post in posts {
//            print("User files: \(post.files)")
//        }
//    }
   

    
    
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
    
    @IBAction func emojicountBtn(_ sender: UIButton) {
        emojiCountbtn?()
    }
    
    @IBAction func likereactionshowbtn(_ sender: Any) {
        //likeAction?()
        likeButtonTapped()
        likeanimastionHeart()

       // toggleLike()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
    
    
    @IBAction func likeBtn(_ sender: Any) {
        likeAction?()
        likeButtonTapped()
        animastionHeart.isHidden = true
        
    }
    @objc func likeButtonTapped() {

          // Toggle like button state
          likeBtn.isSelected.toggle()
          
          // Perform animation
          UIView.animate(withDuration: 0.2, animations: {
              // Scale animation
//              self.likeanimastionHeart()

              self.likeBtn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
          }) { _ in
              UIView.animate(withDuration: 0.2) {
                  // Return to original scale
                  self.likeBtn.transform = .identity
              }
          }
      }
    
    
    @objc func likeanimastionHeart() {
        // Perform animation
        likeAction?()
        UIView.animate(withDuration: 0.2, animations: {
            // Make the heart visible and larger
            self.animastionHeart.isHidden = false
            self.animastionHeart.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                // Return the heart to its original size and hide it
                self.animastionHeart.transform = .identity
            }, completion: { _ in
                // Hide the heart after the animation completes
                self.animastionHeart.isHidden = true
            })
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

    @IBAction func seemoreBts(_ sender: Any) {
        
        seemores?()
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

extension FeedImageTableViewCell : UICollectionViewDelegate,SkeletonCollectionViewDataSource {
 
    
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return postImageData?.count ?? 0
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedImageCollectionViewCell", for: indexPath) as! FeedImageCollectionViewCell
           
           
           if let postFile = postImageData?[indexPath.row] {
               let imageUrl = URL(string: postFile.url)
               cell.imageViews.sd_setImage(with: imageUrl, placeholderImage: nil, options: [], completed: { (image, error, cacheType, imageUrl) in
                   if let error = error {
                       print("Error loading image: \(error.localizedDescription)")
                       // Handle the error, e.g., show a placeholder image or a default image
                   }
               })
           }

           return cell
       }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "FeedImageCollectionViewCell"
    }
    
}
