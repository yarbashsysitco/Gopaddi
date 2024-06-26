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
import SkeletonView



class MainVC: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource ,UITabBarControllerDelegate{
    
    @IBOutlet weak var hambLeading: NSLayoutConstraint!
    @IBOutlet weak var hamburgersView: UIView!
    @IBOutlet weak var hambBackVIew: UIView!
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
    var postDatas : [Post]?
    var saveModel : FeedLSModel?
    var likeModel : FeedLSModel?
    var signedIn : Bool = false
    var userKey : String?
    var key : String?
    var caption : String?
    var parents : String?
    var promo : Bool?
    var picture : String?
    var LoginTrue:Bool = true
    let TrueLogin = UserDefaults.standard.set("true", forKey: "LoginTrue")
    @IBOutlet weak var tableHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var tables: UITableView!
    var poste = [String]()
    var task : URLSessionDataTask!
    let refreshControl = UIRefreshControl()
   let  VCaption = ["Absolutely! Gratitude is indeed a transformative practice that goes beyond mere politeness. It's a mindset that can profoundly impact our well-being and outlook on life. When we consciously cultivate gratitude, we shift our focus from what we lack to what we have, fostering a sense of abundance and contentment. This shift in perspective not only enhances our mental and emotional health but also improves our relationships and overall quality of life. Practicing gratitude regularly reminds us to appreciate the small joys and blessings in our lives, leading to greater resilience and happiness.","It's beautiful to hear about your journey toward happiness and freedom, especially through self-reflection and guidance from a spiritual teacher. The path of inner growth often requires courage and perseverance, but the rewards are immeasurable. Gratitude, as you've discovered, is a powerful tool for unlocking inner peace and fulfillment. It reminds us to appreciate the present moment and the blessings that surround us, even amidst challenges.","Absolutely! Gratitude is indeed a transformative practice that goes beyond mere politeness. It's a mindset that can profoundly impact our well-being and outlook on life. When we consciously cultivate gratitude, we shift our focus from what we lack to what we have, fostering a sense of abundance and contentment. This shift in perspective not only enhances our mental and emotional health but also improves our relationships and overall quality of life. Practicing gratitude regularly reminds us to appreciate the small joys and blessings in our lives, leading to greater resilience and happiness.","It's beautiful to hear about your journey toward happiness and freedom, especially through self-reflection and guidance from a spiritual teacher. The path of inner growth often requires courage and perseverance, but the rewards are immeasurable. Gratitude, as you've discovered, is a powerful tool for unlocking inner peace and fulfillment. It reminds us to appreciate the present moment and the blessings that surround us, even amidst challenges.","Absolutely! Gratitude is indeed a transformative practice that goes beyond mere politeness. It's a mindset that can profoundly impact our well-being and outlook on life. When we consciously cultivate gratitude, we shift our focus from what we lack to what we have, fostering a sense of abundance and contentment. This shift in perspective not only enhances our mental and emotional health but also improves our relationships and overall quality of life. Practicing gratitude regularly reminds us to appreciate the small joys and blessings in our lives, leading to greater resilience and happiness.","It's beautiful to hear about your journey toward happiness and freedom, especially through self-reflection and guidance from a spiritual teacher. The path of inner growth often requires courage and perseverance, but the rewards are immeasurable. Gratitude, as you've discovered, is a powerful tool for unlocking inner peace and fulfillment. It reminds us to appreciate the present moment and the blessings that surround us, even amidst challenges.","Absolutely! Gratitude is indeed a transformative practice that goes beyond mere politeness. It's a mindset that can profoundly impact our well-being and outlook on life. When we consciously cultivate gratitude, we shift our focus from what we lack to what we have, fostering a sense of abundance and contentment. This shift in perspective not only enhances our mental and emotional health but also improves our relationships and overall quality of life. Practicing gratitude regularly reminds us to appreciate the small joys and blessings in our lives, leading to greater resilience and happiness.","It's beautiful to hear about your journey toward happiness and freedom, especially through self-reflection and guidance from a spiritual teacher. The path of inner growth often requires courage and perseverance, but the rewards are immeasurable. Gratitude, as you've discovered, is a powerful tool for unlocking inner peace and fulfillment. It reminds us to appreciate the present moment and the blessings that surround us, even amidst challenges.",]

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
        self.tables.reloadData()

        setupImageView()
        tables.addSubview(refreshControl)
           refreshControl.addTarget(self, action: #selector(callFeeds), for: .valueChanged)
        "okkkkk"
        userKey = UserDefaults.standard.string(forKey: "userid")
        print(userKey)
       
        profilePicSetUp()
        tables.delegate = self
        tables.dataSource = self
        self.tables.register(UINib.init(nibName: "TextTableViewCell", bundle: .main), forCellReuseIdentifier: "TextTableViewCell")
//        self.tables.register(UINib.init(nibName: "ImageTableViewCell", bundle: .main), forCellReuseIdentifier: "ImageTableViewCell")
//
        self.tables.register(UINib.init(nibName: "FeedImageTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedImageTableViewCell")
        tables.estimatedRowHeight = 650
        tables.rowHeight = UITableView.automaticDimension
        //        tables.reloadData()
        trendingView.isHidden = true
        trendBtn.titleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        FloatingActionButton()
        tabBarController?.delegate = self
        self.hambBackVIew.isHidden = true
        self.view.clipsToBounds = true
        hambTap()
        print("ts")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.callFeeds()

//        }
        callFeeds2()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tables.reloadData()
       
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
        
        actionButton.addItem(title: "Feeds", image: UIImage(named: "NotePesvg")) { item in
            self.createFeedBtnClicked()
        }

        actionButton.addItem(title: "Diary", image: UIImage(named: "Notebooksvg")) { item in
            self.DiaryFeedBtnClicked()
        }

        // Add the button to the view
        view.addSubview(actionButton)

        // Set the button's constraints (optional, adjust as needed)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
    }
    
    @IBAction func notificationButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "NotificationMain", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController")as! NotificationViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
       
        self.present(vc!, animated: true)
//        self.hambBackVIew.isHidden = false
//        UIView.animate(withDuration: 0.5) {
//            self.hambLeading.constant = 0
//            self.view.layoutIfNeeded()
//
//        }
    }
    func profilePicSetUp(){
        picture = UserDefaults.standard.string(forKey: "picture")
        profileImgView.sd_setImage(with:URL(string: picture ?? ""))
    }
    
    @objc func callFeeds(){
        tables.isSkeletonable = true
        let lightGrayColor  = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tables.showAnimatedSkeleton(usingColor: lightGrayColor, transition: .crossDissolve(0.25))
        
//        tables.showLoading()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.apiManager.feedsDetails(userKey: self.userKey!) { result in
                switch result  {
                case.success(let model):
                    DispatchQueue.main.async {
                        self.resultData = model
                        self.tables.reloadData()
                        self.tables.hideSkeleton()
                        self.tables.stopLoading()
                        self.refreshControl.endRefreshing()

                    }
                case.failure(let error):
                    self.tables.stopLoading()
                    print(error.localizedDescription)
                }
            }

//        }
    }
    func callFeeds2() {
        self.apiManager.getPostBody { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.postDatas = model.data?.first?.posts
//                    print(model)
                    print("resposeeeee")
                    self.tables.reloadData()

//                    self.tables.stopLoading()
                    self.refreshControl.endRefreshing()
                
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FeedImageTableViewCell"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDatas?.count ?? 1
    }
    func compressImage(image: UIImage, compressionQuality: CGFloat) -> Data? {
        return image.jpegData(compressionQuality: compressionQuality)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedImageTableViewCell", for: indexPath) as! FeedImageTableViewCell
     
            cell.selectionStyle = .none
        
        
        if let resultData = postDatas, indexPath.row < resultData.count {
            let feCreators = resultData[indexPath.row].userinfo
            if !feCreators.isEmpty {
                let profileStringUrl = feCreators[0].picture ?? ""
                // Use profileStringUrl here
                print(profileStringUrl)
                let profileImageUrl = URL(string: profileStringUrl) ?? URL(fileURLWithPath: "")
                cell.us_picture.sd_setImage(with:profileImageUrl)
            }
        }
        
        if let usernames = postDatas?[indexPath.row].userinfo[0].firstName,let usernames2 = postDatas?[indexPath.row].userinfo[0].firstName  {
            cell.userName.text = "\(usernames)  \(usernames2)"
            print("usernames\(usernames)")
       }
        
        if let files = postDatas?[indexPath.row].files, !files.isEmpty {
            cell.postImageData = files
        } else {
            print("hleolllll")
            let demoFile = PostFile(id: "demo_image", url: "https://images.unsplash.com/photo-1597429926308-ffc8cd6f55fd?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=800&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTcxMTk1MDIyMQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1900")
            cell.postImageData = [demoFile]
        }
        cell.emojiCountbtn = { [weak self] in
            guard let self = self else { return }
            
            let vc = UIStoryboard(name: "ReactionMain", bundle: nil).instantiateViewController(withIdentifier: "ReactionMainViewController")as! ReactionMainViewController
             vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            self.setupLongPressGesture()
        }
            cell.makeClickActive(value: true)
        let promos = postDatas?[indexPath.row].promotion
            promo = promos

//        cell.feedCaption.text = postDatas?[indexPath.row].caption
        cell.feedCaption.text = VCaption[indexPath.row]
        
        
        
        cell.feedShare.text = postDatas?[indexPath.row].sharesCount
        cell.feedLikes.text = postDatas?[indexPath.row].likesCount
        cell.feedSaves.text = postDatas?[indexPath.row].savesCount
        cell.feedViews.text = postDatas?[indexPath.row].viewsCount
        cell.feedComments.text = postDatas?[indexPath.row].commentsCount
        
        if let fe_comments = postDatas?[indexPath.row].commentsCount {
            print(fe_comments)
            cell.feedComents2.text = fe_comments
            if fe_comments == "0" {
            cell.feedComents2.text = ""
            }else if fe_comments == "1"{
                cell.feedComents2.text = "View 1 comment"
            }else{
               cell.feedComents2.text = "View all \(fe_comments) comments"
            }
        }
        
        
       // likedStatus
            
            if let createdAtString = postDatas?[indexPath.row].createdAt{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let createdAt = dateFormatter.date(from: createdAtString) {
                    let currentDate = Date()
                    let calendar = Calendar.current
                    let differenceComponents = calendar.dateComponents([.year, .month, .weekOfMonth, .day], from: createdAt, to: currentDate)
                    
                    var timeAgoString = ""

                    if let years = differenceComponents.year, years > 0 {
                        timeAgoString = "\(years) year\(years > 1 ? "s" : "") "
                    }
                    if let months = differenceComponents.month, months > 0 {
                        timeAgoString += "\(months) month\(months > 1 ? "s" : "") "
                        // Exclude years if months are present
                        timeAgoString = timeAgoString.replacingOccurrences(of: #" (\d+) year"#, with: "", options: .regularExpression)
                    }
                    else if let weeks = differenceComponents.weekOfMonth, weeks > 0 {
                        timeAgoString += "\(weeks) week\(weeks > 1 ? "s" : "") "
                        // Exclude days if weeks are present
                        timeAgoString = timeAgoString.replacingOccurrences(of: #" (\d+) day"#, with: "", options: .regularExpression)
                    }
                    else if let days = differenceComponents.day, days > 0 {
                        timeAgoString += "\(days) day\(days > 1 ? "s" : "") "
                    }

                    if timeAgoString.isEmpty {
                              timeAgoString = "Today"
                    } else {
                              timeAgoString += "ago"
                          }
                    cell.feedCreatedDate.text = timeAgoString
                } else {
                    // Handle error if unable to convert string to date
                    cell.feedCreatedDate.text = "Unknown"
                }
            } else {
                // Handle error if createdAtString is nil
                cell.feedCreatedDate.text = "Unknown"
            }
        
        
//            cell.feedComents2.text = resultData?[indexPath.row].fe_comments
//
//        if let counts = resultData?[indexPath.row].fe_comments {
            
//            if counts.count == 0 {
//                                cell.feedComents2.isHidden = true
//
//            } else  if counts.count == 1 {
//                cell.feedComents2.text = "View all \(counts.count) comments "
//            }
//
//            cell.feedComents2.text = "View all \(counts.count) comments "
            
        //}
//
//    if let comments = resultData?[indexPath.row].fe_comments {
//            if comments.count == 0 {
//                cell.feedComents2.text = "View"
//
//                cell.feedComents2.isHidden = true
//            } else if comments.count == 1 {
//                cell.feedComents2.text = "View 1 comment"
//            }else{
//                cell.feedComents2.text = "View all \(comments.count) comments"
//            }
//
//        }
        

            if postDatas?[indexPath.row].savedStatus == true {
               // cell.saveImgView.tintColor = .systemYellow
                if let image = UIImage(named: "sv1") {
                    cell.saveImgView.image = image
                }
                
            }else{
                if let image = UIImage(named: "sv0") {
                    cell.saveImgView.image = image
                }
            }
        
            if postDatas?[indexPath.row].likedStatus == true {
              cell.likeImgView.tintColor = .systemRed
                if let image = UIImage(named: "Heart0") {
                    cell.likeBtn.setImage(image, for: .normal)
                       }
            }else{
//                cell.likeImgView.tintColor = .systemGray3
                if let image = UIImage(named: "Heart1") {
                    cell.likeBtn.setImage(image, for: .normal)
                       }
            }
            
            if postDatas?[indexPath.row].promotion == true {
                cell.fePromotion.isHidden = true
            }else {
                cell.fePromotion.isHidden = false
            }
            cell.likeAction = {
                
                if let image = UIImage(named: "Heart0") {
                                                   cell.likeBtn.setImage(image, for: .normal)
                                                      }
                print("Like Btn Clicked")
//                self.promo = self.resultData?[indexPath.row].fe_promotion
//                self.key = self.resultData?[indexPath.row].fe_id
//                self.apiManager.feedsLikeSave(userKey: self.userKey!, key: self.key!, promotion: self.promo!, action: "like" ){ result in
//                    switch result {
//                    case .success(let model) :
//                        DispatchQueue.main.async {
//                            if  model.result?[0].liked == "1"{
//                                cell.likeImgView.tintColor = .systemRed
                                
//                                if let image = UIImage(named: "Heart0") {
//                                    cell.likeBtn.setImage(image, for: .normal)
//                                       }
//                            }else{
//                                cell.likeImgView.tintColor = .systemGray3
//                                if let image = UIImage(named: "Heart1") {
//                                    cell.likeBtn.setImage(image, for: .normal)
//                                       }
//                            }
//                            cell.feedLikes.text = String((model.result?[0].likes) ?? 0)
//                        }
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
            }
        cell.seemores = { [weak self] in
            // Update the number of lines for feedCaption to show all lines
            cell.feedCaption.numberOfLines = 0
            
            // Reload the cell to reflect the updated content and height
            tableView.beginUpdates()
            tableView.endUpdates()
        }
            
            let comment = "Olufunmi: Chasing sunsets and making memories that will last a lifetime. ☀️🌴✨." // Assuming `comments` is your array of comments
               let boldName = "Olufunmi:"
               cell.setFirstCommentWithBoldName(comment: comment, boldName: boldName)
            cell.actionBlock = {
                let vc = UIStoryboard(name: "BookMarkMain", bundle: nil).instantiateViewController(withIdentifier: "BookMarkPopUp")as! BookMarkPopUp
                self.present(vc, animated: true)
                
                
//                
//                print("Saved Clicked")
//                self.promo = self.resultData?[indexPath.row].fe_promotion
//                self.key = self.resultData?[indexPath.row].fe_id
//                self.apiManager.feedsLikeSave(userKey: self.userKey!, key: self.key!, promotion: self.promo!, action: "save" ){ result in
//                    switch result {
//                        
//                        
//                    case .success(let model) :
//                        DispatchQueue.main.async {
//                            if  model.result?[0].saved == "1"{
//                                
//                                if let image = UIImage(named: "sv1") {
//                                    cell.saveImgView.image = image
//                                }
//                                
//                               // cell.saveImgView.tintColor = .systemYellow
//                                
//                                
//                            }else{
//                                if let image = UIImage(named: "sv0") {
//                                    cell.saveImgView.image = image
//                                }
//                                
////                                cell.saveImgView.tintColor = .systemGray3
//                            }
//                            cell.feedSaves.text = String(model.result?[0].saves ?? 0)
//                        }
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
            }
        
        cell.emojiss = { [weak self] in
            guard let self = self else { return }

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReactionsVC") as! ReactionsVC
            // vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)

            self.setupLongPressGesture()
        }

        
        
            cell.popUpButton = {
                
                print("PopUp Clicked")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FeedPopUpViewController") as? FeedPopUpViewController
                
//                vc?.userKey = self.userKey!
//                vc?.key = (self.resultData?[indexPath.row].fe_id)!
//                vc?.caption = (self.resultData?[indexPath.row].fe_caption)!
//                vc?.creator = (self.resultData?[indexPath.row].fe_creator[0].us_name)!
//                vc?.imgUrl = (self.resultData?[indexPath.row].fe_file)!
//            
                self.present(vc!, animated: true)
                self.callFeeds()
                tableView.reloadData()
            }
//            cell.shareAction = {
//                let appName = "Gopaddi"
//                let creator = self.resultData?[indexPath.row].fe_creator[0].us_name
//                let imageUrl = NSURL(string: (self.resultData?[indexPath.row].fe_file) ?? "")
//                let shareAll = [appName , creator! , imageUrl!]
//                let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
//                activityViewController.popoverPresentationController?.sourceView = self.view
//                self.present(activityViewController, animated: true, completion: nil)
//            }
//            cell.postComment = {
//                guard let comment = cell.testView.text else { return }
//                self.promo = self.resultData?[indexPath.row].fe_promotion
//                self.key = self.resultData?[indexPath.row].fe_id
//                
//                self.apiManager.feedsComment(userKey: self.userKey!, key: self.key!, parent: "0", promotion: self.promo!, msg: comment){ result in
//                    switch result {
//                    case .success(let model) :
//                        DispatchQueue.main.async {
//                            self.response = model
//                            cell.testView.text = "Add Comments"
//                            self.callFeeds()
//                            tableView.reloadData()
//                        }
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            
//            
//            cell.comment = {
//                
//                self.callApi(key: (self.resultData?[indexPath.row].fe_id)!, promo: (self.resultData?[indexPath.row].fe_promotion)!, indexPathRow: indexPath.row)
//                
//            }
//            
//
     
            return cell
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 5 {
//            return 177    }
//        else {
            return UITableView.automaticDimension
//        }
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
    func DiaryFeedBtnClicked(){
        let vc = (UIStoryboard.init(name: "DiaryMain", bundle: Bundle.main).instantiateViewController(withIdentifier: "DiaryViewController") as? DiaryViewController)!
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

extension MainVC{
    
    func hambTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(hampTapGesture))
        hamburgersView.isUserInteractionEnabled = true
        hamburgersView.addGestureRecognizer(tap)
    }
    @objc func hampTapGesture(){
        UIView.animate(withDuration: 0.5) {
            self.hambLeading.constant = -350
            self.view.layoutIfNeeded()
        }
    }
}
