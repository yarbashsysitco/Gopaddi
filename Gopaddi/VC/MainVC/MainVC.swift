//
//  MainVC.swift
//  Gopaddi
//
//  Created by jizan k on 06/12/22.
//

import UIKit
import SDWebImage
import Kingfisher
import JJFloatingActionButton


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UITabBarControllerDelegate{
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainProfileImageBtn: UIButton!
    
    @IBOutlet weak var foryouView: UIView!
    
    @IBOutlet weak var trendingView: UIView!
    
    @IBOutlet weak var forBtn: UIButton!
    
    @IBOutlet weak var trendBtn: UIButton!
    let apiManager = ApiManager()
    var response : CommonResponse?
    var resultData : [FeedResult]?
    var saveModel : FeedLSModel?
    var likeModel : FeedLSModel?
    var signedIn : Bool = false
    var userKey : String?
    var key : String?
    var caption : String?
    var parents : String?
    var promo : String?
    var picture : String?
    var LoginTrue:Bool = true
    let TrueLogin = UserDefaults.standard.set("true", forKey: "LoginTrue")
    @IBOutlet weak var tableHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var tables: UITableView!
    var poste = [String]()
    var task : URLSessionDataTask!
    
    let iconsContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        // configuration options
        let iconHeight: CGFloat = 38
        let padding: CGFloat = 6
        
        let images = [#imageLiteral(resourceName: "emo1.svg"), #imageLiteral(resourceName: "emo2.svg"), #imageLiteral(resourceName: "emo3.svg"), #imageLiteral(resourceName: "emo4.svg"), #imageLiteral(resourceName: "emo5.svg"), #imageLiteral(resourceName: "emo6.svg")]
        
        let arrangedSubviews = images.map({ (image) -> UIView in
            let imageView = UIImageView(image: image)
            imageView.layer.cornerRadius = iconHeight / 2
            // required for hit testing
            imageView.isUserInteractionEnabled = true
            return imageView
        })
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerView.addSubview(stackView)
        
        let numIcons = CGFloat(arrangedSubviews.count)
        let width =  numIcons * iconHeight + (numIcons + 1) * padding
        
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
        // shadow
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = containerView.frame
        
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        userKey = UserDefaults.standard.string(forKey: "logkey")
        callFeeds()
        print(userKey)
        print("Hello")
        profilePicSetUp()
        tables.delegate = self
        tables.dataSource = self
        self.tables.register(UINib.init(nibName: "TextTableViewCell", bundle: .main), forCellReuseIdentifier: "TextTableViewCell")
        self.tables.register(UINib.init(nibName: "ImageTableViewCell", bundle: .main), forCellReuseIdentifier: "ImageTableViewCell")
        tables.estimatedRowHeight = 650
        tables.rowHeight = UITableView.automaticDimension
        //        tables.reloadData()
        trendingView.isHidden = true
        trendBtn.titleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        FloatingActionButton()
        tabBarController?.delegate = self
        print("okkHello")

    }
    
      func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
          if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
              print("Tab \(index) clicked!")
              if index == 0 {
//                  scrollToTop()
                  print("scrollToTop")
                  scrollToTop()
              }else{
                  print(index)
              }
          }
      }

    @IBAction func shopingBtn(_ sender: Any) {
//        scrollToTop()
    }
    
    func FloatingActionButton() {
        // Create the floating action button
        let actionButton = JJFloatingActionButton()

        // Set the button color to blue
        actionButton.buttonColor = .systemBlue

        // Configure the button
        actionButton.addItem(title: "Feeds", image: UIImage(named: "circle32")) { item in
            self.createFeedBtnClicked()
        }

        actionButton.addItem(title: "Diary", image: UIImage(named: "cr32")) { item in
            // Handle item 2 tap
        }

        // Add the button to the view
        view.addSubview(actionButton)

        // Set the button's constraints (optional, adjust as needed)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
    }

    
    @IBAction func foryouBtn(_ sender: Any) {
     
        foryouView.isHidden = false
        trendingView.isHidden = true
        forBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        trendBtn.titleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
      
    }
    
    @IBAction func trendingBtn(_ sender: Any) {
//        // Show loading animation
//        showLoadingAnimation()
//        tables.reloadData()
////        hideLoadingAnimation()
        trendingView.isHidden = false
        foryouView.isHidden = true
        trendBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        forBtn.titleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

    }
    func showLoadingAnimation() {
        // Implement your loading animation here.
        // You can use UIActivityIndicatorView or any other animation method.
        // For example, using UIActivityIndicatorView:
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        // Add the activity indicator to your view hierarchy and position it as needed.
        // For example, adding it as an overlay on top of the table view:
        activityIndicator.center = tables.center
        tables.addSubview(activityIndicator)
    }

    func hideLoadingAnimation() {
        // Implement code to hide or remove the loading animation.
        // For example, if using UIActivityIndicatorView, you can call:
        for subview in tables.subviews {
            if let activityIndicator = subview as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    private func scrollToTop() {
          let indexPath = IndexPath(row: 0, section: 0) // Assuming you want to scroll to the first row of the first section
        tables.scrollToRow(at: indexPath, at: .top, animated: true)
      }

    private func setupImageView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profileImgView.layer.borderWidth = 2
        profileImgView.layer.cornerRadius = profileImgView.frame.width/2
        profileImgView.layer.borderColor = UIColor.systemGray5.cgColor
        profileImgView.isUserInteractionEnabled = true
        profileImgView.addGestureRecognizer(tapGesture)
    }
    @objc func didTapImage(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    func profilePicSetUp(){
        picture = UserDefaults.standard.string(forKey: "picture")
        profileImgView.sd_setImage(with:URL(string: picture ?? ""))
    }
    
    func callFeeds(){
        tables.showLoading()
        apiManager.feedsDetails(userKey: userKey!) { result in
            switch result  {
            case.success(let model):
                DispatchQueue.main.async {
                    self.resultData = model
                    self.tables.stopLoading()
                    self.tables.reloadData()
                }
            case.failure(let error):
                self.tables.stopLoading()
                print(error.localizedDescription)
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultData?.count ?? 1
    }
    func compressImage(image: UIImage, compressionQuality: CGFloat) -> Data? {
        return image.jpegData(compressionQuality: compressionQuality)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 5)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.selectionStyle = .none
            
            if let resultData = resultData, indexPath.row < resultData.count {
                let feCreators = resultData[indexPath.row].fe_creator

                if !feCreators.isEmpty {
                    let profileStringUrl = feCreators[0].us_picture ?? ""
                    // Use profileStringUrl here
                    print(profileStringUrl)
                    let profileImageUrl = URL(string: profileStringUrl) ?? URL(fileURLWithPath: "")
                    cell.us_picture.sd_setImage(with:profileImageUrl)


                }
            }
            
            
            let postedImageStringUrl = self.resultData?[indexPath.row].fe_file ?? ""
            print(postedImageStringUrl)

            if let imageUrl = URL(string: postedImageStringUrl) {
                cell.postImage.sd_setImage(with: imageUrl, placeholderImage: nil, options: [], completed: { (image, error, cacheType, imageUrl) in
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                        // Handle the error, e.g., show a placeholder image or a default image
                    }
                })
            } else {
                // Handle the case where the URL is not valid
                print("Invalid URL")
                // You might want to show a placeholder image or a default image here as well
            }


            
            
            
            cell.makeClickActive(value: true)
            promo = resultData?[indexPath.row].fe_promotion
            key = resultData?[indexPath.row].fe_id
//            DispatchQueue.main.async {
//               
//            }
            //            let postedImageStringUrl = self.resultData?[indexPath.row].fe_file ?? ""
            //            cell.postImage.kf.setImage(with: URL(string: "https://bird.decordtech.com/golive/../b2cdemo/uploads/feed/605461.jpg"))
            caption = resultData?[indexPath.row].fe_caption
            cell.userName.text = resultData?[indexPath.row].fe_creator[0].us_name
            cell.feedCaption.text = resultData?[indexPath.row].fe_caption
            cell.feedShare.text = resultData?[indexPath.row].fe_shares
            cell.feedLikes.text = resultData?[indexPath.row].fe_likes
            cell.feedSaves.text = resultData?[indexPath.row].fe_saves
            cell.feedViews.text = resultData?[indexPath.row].fe_views
            cell.feedComments.text = resultData?[indexPath.row].fe_comments
            cell.feedComents2.text = resultData?[indexPath.row].fe_comments
            cell.feedCreatedDate.text = resultData?[indexPath.row].fe_created_at
            cell.feedCaption.text = resultData?[indexPath.row].fe_caption
            if resultData?[indexPath.row].fe_saved == "1"{
                cell.saveImgView.tintColor = .systemYellow
            }else{
                cell.saveImgView.tintColor = .systemGray3
            }
            if resultData?[indexPath.row].fe_liked == "1"{
//                cell.likeImgView.tintColor = .systemRed
                if let image = UIImage(named: "Heart0") {
                         cell.likeImgView.image = image
                     }
            }else{
//                cell.likeImgView.tintColor = .systemGray3
                if let image = UIImage(named: "Heart1") {
                           cell.likeImgView.image = image
                    
                       }
            }
            
            if resultData?[indexPath.row].fe_promotion == "0"{
                cell.fePromotion.isHidden = true
            }else {
                cell.fePromotion.isHidden = false
            }
            cell.likeAction = {
                print("Like Btn Clicked")
                self.promo = self.resultData?[indexPath.row].fe_promotion
                self.key = self.resultData?[indexPath.row].fe_id
                self.apiManager.feedsLikeSave(userKey: self.userKey!, key: self.key!, promotion: self.promo!, action: "like" ){ result in
                    switch result {
                    case .success(let model) :
                        DispatchQueue.main.async {
                            if  model.result?[0].liked == "1"{
//                                cell.likeImgView.tintColor = .systemRed
                                if let image = UIImage(named: "Heart0") {
                                         cell.likeImgView.image = image
                                    
                                     }
                            }else{
//                                cell.likeImgView.tintColor = .systemGray3
                                if let image = UIImage(named: "Heart1") {
                                           cell.likeImgView.image = image
                                       }
                            }
                            cell.feedLikes.text = String((model.result?[0].likes) ?? 0)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            cell.actionBlock = {
                print("Saved Clicked")
                self.promo = self.resultData?[indexPath.row].fe_promotion
                self.key = self.resultData?[indexPath.row].fe_id
                self.apiManager.feedsLikeSave(userKey: self.userKey!, key: self.key!, promotion: self.promo!, action: "save" ){ result in
                    switch result {
                    case .success(let model) :
                        DispatchQueue.main.async {
                            if  model.result?[0].saved == "1"{
                                cell.saveImgView.tintColor = .systemYellow
                            }else{
                                cell.saveImgView.tintColor = .systemGray3
                            }
                            cell.feedSaves.text = String(model.result?[0].saves ?? 0)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            cell.popUpButton = {
                
                print("PopUp Clicked")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FeedPopUpViewController") as? FeedPopUpViewController
                vc?.userKey = self.userKey!
                vc?.key = (self.resultData?[indexPath.row].fe_id)!
                vc?.caption = (self.resultData?[indexPath.row].fe_caption)!
                vc?.creator = (self.resultData?[indexPath.row].fe_creator[0].us_name)!
                vc?.imgUrl = (self.resultData?[indexPath.row].fe_file)!
            
                self.present(vc!, animated: false)
                self.callFeeds()
                tableView.reloadData()
            }
            cell.shareAction = {
                let appName = "Gopaddi"
                let creator = self.resultData?[indexPath.row].fe_creator[0].us_name
                let imageUrl = NSURL(string: (self.resultData?[indexPath.row].fe_file) ?? "")
                let shareAll = [appName , creator! , imageUrl!]
                let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }
            cell.postComment = {
                guard let comment = cell.testView.text else { return }
                self.promo = self.resultData?[indexPath.row].fe_promotion
                self.key = self.resultData?[indexPath.row].fe_id
                
                self.apiManager.feedsComment(userKey: self.userKey!, key: self.key!, parent: "0", promotion: self.promo!, msg: comment){ result in
                    switch result {
                    case .success(let model) :
                        DispatchQueue.main.async {
                            self.response = model
                            cell.testView.text = "Add Comments"
                            self.callFeeds()
                            tableView.reloadData()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            cell.comment = {
                
                self.callApi(key: (self.resultData?[indexPath.row].fe_id)!, promo: (self.resultData?[indexPath.row].fe_promotion)!, indexPathRow: indexPath.row)
                
            }
            
            cell.emojiss = { [weak self] in
                guard let self = self else { return }

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReactionsVC") as! ReactionsVC
                // vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)

                self.setupLongPressGesture()
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            return 177    }
        else {
            return UITableView.automaticDimension
        }
    }
//    @IBAction func createFeedBtnClicked(_ sender: Any) {
//
//    }
    
    func createFeedBtnClicked(){
        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FeedsViewController") as? FeedsViewController)!
        vc.userKey = userKey!
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func callApi(key : String,promo : String, indexPathRow : Int){
        view.showLoading()
        apiManager.feedPostedComment(userKey: userKey!, key: key, promotion: promo ) { result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    
                    if model.code == "200" {
                        self.view.stopLoading()
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FeedsCommentViewController") as? FeedsCommentViewController
                        vc?.userKey = self.userKey!
                        vc?.date = (self.resultData?[indexPathRow].fe_created_at)!
                        vc?.userName = (self.resultData?[indexPathRow].fe_creator[0].us_name)!
                        vc?.profileImageUrl = self.resultData?[indexPathRow].fe_creator[0].us_picture ?? ""
                        vc?.postedImageUrl = self.resultData?[indexPathRow].fe_file ?? ""
                        vc?.feedCaption = (self.resultData?[indexPathRow].fe_caption)!
                        vc?.feedlikes = (self.resultData?[indexPathRow].fe_likes)!
                        vc?.feedcomment = (self.resultData?[indexPathRow].fe_comments)!
                        vc?.feedshare = (self.resultData?[indexPathRow].fe_shares)!
                        vc?.feedsave = (self.resultData?[indexPathRow].fe_saves)!
                        vc?.feedLikeImg = (self.resultData?[indexPathRow].fe_liked)!
                        vc?.postSave = (self.resultData?[indexPathRow].fe_saved)!
                        vc!.commentInfo = model.result!
                        //                        vc.fcReplies = model.result!
                        vc?.feedData = self.resultData?[indexPathRow]
                        let nav = UINavigationController(rootViewController: vc!)
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true)
                    }else{
                        self.view.stopLoading()
                        let alert = UIAlertController(title: "Sorry!", message: "Something went wrong", preferredStyle: .alert)
                        let btn = UIAlertAction(title: "Ok", style: .default) {_ in
                            alert.dismiss(animated: true)
                        }
                        alert.addAction(btn)
                        self.present(alert, animated: true)
                    }
                }
            case .failure( let error):
                self.view.stopLoading()
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
    fileprivate func setupLongPressGesture() {
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            
            // clean up the animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: 50)
                self.iconsContainerView.alpha = 0
                
            }, completion: { (_) in
                self.iconsContainerView.removeFromSuperview()
            })
            
            
        } else if gesture.state == .changed {
            handleGestureChanged(gesture: gesture)
        }
    }
    
    fileprivate func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: self.iconsContainerView)
        print(pressedLocation)
        
        let fixedYLocation = CGPoint(x: pressedLocation.x, y: self.iconsContainerView.frame.height / 2)
        
        let hitTestView = iconsContainerView.hitTest(fixedYLocation, with: nil)
        
        if hitTestView is UIImageView {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
                
            })
        }
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconsContainerView)
        
        let pressedLocation = gesture.location(in: self.view)
        print(pressedLocation)
        
        // transformation of the red box
        let centeredX = (view.frame.width - iconsContainerView.frame.width) / 2
        
        iconsContainerView.alpha = 0
        self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.iconsContainerView.alpha = 1
            self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
        })
    }
    
    override var prefersStatusBarHidden: Bool { return true }
}

