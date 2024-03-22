//
//  FeedsCommentViewController.swift
//  Gopaddi
//
//  Created by jizan k on 22/02/23.
//

import UIKit

class FeedsCommentViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var Gopostlabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var CommentTxt: UITextField!
    let apiManager = ApiManager()
    var commonResponse : CommonResponse?
    var commentInfo = [ResponseInfo]()
    var fcReplies : FcRepliesDatum?
    var feedData : FeedResult?
    var feedComment : FeedCommentLike?
    var userName = String()
    var date = String()
    var profileImageUrl = String()
    var postedImageUrl = String()
    var postSave = String()
    var feedCaption = String()
    var feedlikes = String()
    var feedcomment = String()
    var feedshare = String()
    var feedsave = String()
    var feedLikeImg = String()
    var promo = String()
    var userKey = String()
    var key = String()
    var isReplyClicked : Bool = false
    var sectionClicked : Int = 0
    var prevClicked : Int = 0
    var postClicked : Bool = false
    
    var post : (() -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello")
        tableview.estimatedRowHeight = 300
    
        tableview.register(UINib.init(nibName: "CommentHeadTableViewCell", bundle: .main), forCellReuseIdentifier: "CommentHeadTableViewCell")
        tableview.register(CommentReplyTableViewCell.self, forCellReuseIdentifier: CommentReplyTableViewCell.identifier)
        tableview.register(CommentsTableViewCell.self, forCellReuseIdentifier: CommentsTableViewCell.identifier)
        tableview.register(PostRepliesTableViewCell.self, forCellReuseIdentifier: PostRepliesTableViewCell.identifier)
        tableview.sectionHeaderTopPadding = 0
        CommentTxt.delegate = self
        Gopostlabel.font = UIFont(name: "Poppins-Regular", size: 16)
        navigationController?.isNavigationBarHidden = true
        
    }
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func PostcommentBtn(_ sender: UIButton) {
        post?()
            if CommentTxt.text != "Add comment..." {
                guard let comment = CommentTxt.text else { return }
                if !comment.isEmpty{
                    self.promo = self.feedData!.fe_promotion
                    self.key = self.feedData!.fe_id
                    self.apiManager.feedsComment(userKey: self.userKey, key: self.key, parent: "0", promotion: self.promo, msg: comment){ result in
                        switch result {
                        case .success(let model) :
                            if model.code == "200" {
                                DispatchQueue.main.async { [self] in
                                    CommentTxt.textColor = .systemGray
//                                        cell.msgTView.text = "Add Comments..."
                                    CommentTxt.resignFirstResponder()
                                    self.callApi(key: self.key, promo: self.promo)
                                }}
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        CommentTxt.text = ""
        print("hello")
        }
    
    
    
}
extension FeedsCommentViewController : UITableViewDelegate, UITableViewDataSource{
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentInfo.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if section > 0 && section < commentInfo.count + 1{
            
            if sectionClicked != 0 && sectionClicked == section {
                if prevClicked != sectionClicked{
                    
                        prevClicked = sectionClicked
                        return commentInfo[sectionClicked - 1].fc_replies_data!.count + 1
                    
                }else   if postClicked == true {
                    self.postClicked = false
                   return commentInfo[sectionClicked - 1].fc_replies_data!.count + 1
                }
                
                else{
                    prevClicked = 0
                    return 0
                }
            }
            return 0
        }
        return 1
    } 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 && section < commentInfo.count + 1{
            let header = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.identifier) as!     CommentsTableViewCell
            header.config(commentData: commentInfo[section - 1])
            header.likeBtn = {
                print("Like Btn Clicked")
                self.apiManager.feedsCommentLike(userKey: self.userKey, key: self.commentInfo[section - 1].fc_id!, emoji: "", action: "like"){ result in
                    switch result {
                    case .success(let model) :
                        DispatchQueue.main.async {
                            if  model.liked == 1{
//                                header.likeButton.tintColor = .systemBlue
                            }else{
//                                header.likeButton.tintColor = .systemGray
                            }
//                            header.noOfLikes.text = "(" + String(model.likes!) + ")"
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            header.replyComment = {
                self.sectionClicked = section
               // self.tableview.reloadSections(IndexSet(integer: section), with: .fade)
                let contentOffset = self.tableview.contentOffset
                self.tableview.reloadData()
                self.tableview.layoutIfNeeded()
                self.tableview.setContentOffset(contentOffset, animated: false)
               
            }
            return header
        }
        return UITableViewHeaderFooterView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 && section < commentInfo.count + 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.identifier) as! CommentsTableViewCell
            cell.config(commentData: (commentInfo[section - 1]))
            cell.layoutIfNeeded()
            let size = cell.contentView.systemLayoutSizeFitting(CGSize(width: tableView.frame.width, height: UIView.layoutFittingCompressedSize.height),withHorizontalFittingPriority: .required,verticalFittingPriority: .fittingSizeLevel)
            return size.height + 10

        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentHeadTableViewCell", for: indexPath) as! CommentHeadTableViewCell
            cell.config( profileImg: profileImageUrl, dated: date,caption: feedCaption, profName: userName, Likes: feedlikes, Comment: feedcomment, Share: feedshare, Save: feedsave, postImg: postedImageUrl, likeimg: feedLikeImg, saveImg: postSave)
           
//            cell.poastImg.sd_setImage(with: URL(string: "https://bird.decordtech.com/golive/../b2cdemo/uploads/feed/605461.jpg"))
            
            return cell
        }
        else{
            if indexPath.row != commentInfo[indexPath.section - 1].fc_replies_data!.count  {
                let cell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.identifier, for: indexPath) as! CommentReplyTableViewCell
                
                    cell.config(commentData: (commentInfo[indexPath.section - 1].fc_replies_data?[indexPath.row])!)
//                cell.likeClicked = {
//                    print("Like Btn Clicked")
//                    self.apiManager.feedsCommentLike(userKey: self.userKey, key: (self.commentInfo[indexPath.section - 1].fc_replies_data?[indexPath.row].fc_id)!, emoji: "", action: "like"){ result in
//                        switch result {
//                        case .success(let model) :
//                            DispatchQueue.main.async {
//                                if  model.liked == 1{
//                                    cell.likeButton.tintColor = .systemBlue
//                                }else{
//                                    cell.likeButton.tintColor = .systemGray
//                                }
//                                cell.noOfLikes.text = "(" + String(model.likes!) + ")"
//                            }
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
//                }

                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: PostRepliesTableViewCell.identifier, for: indexPath) as! PostRepliesTableViewCell
                cell.post = {
                    self.promo = self.feedData!.fe_promotion
                    self.key = self.feedData!.fe_id
                    if cell.commentTF.text != "Add Comments..." {
                        guard let comment = cell.commentTF.text else { return }
                    if !comment.isEmpty{
                        self.apiManager.feedsComment(userKey: self.userKey, key: self.key, parent: self.commentInfo[indexPath.section - 1].fc_id!, promotion: self.promo, msg: comment){ result in
                            switch result {
                            case .success(let model) :
                                DispatchQueue.main.async {
                                    self.postClicked = true
                                    cell.commentTF.textColor = .systemGray
                                    cell.commentTF.text = "Add Comments..."
                                    cell.commentTF.resignFirstResponder()
                                    self.promo = self.feedData!.fe_promotion
                                    self.key = self.feedData!.fe_id
                                    self.callApi(key: self.key, promo: self.promo)
//                                    self.callReplyApi(fc_Id: self.commentInfo[indexPath.section - 1].fc_id!, section: IndexSet(integer: indexPath.section))
                                  
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                }

                }
                return cell
            }
        }
    }
    @objc func callReplyApi(fc_Id : String, section : IndexSet){
        let userKey = UserDefaults.standard.string(forKey: "logkey")
        tableview.showLoading()
        self.apiManager.feedCommentReply(userKey: userKey!, key: fc_Id){ result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    self.tableview.stopLoading()
                    self.fcReplies = model
                    self.tableview.reloadSections(section, with: .fade)
                }
            case .failure( let error):
                self.tableview.stopLoading()
                print(error.localizedDescription)
            }
        }
        
    }
    private func callApi(key : String,promo : String){
        view.showLoading()
        apiManager.feedPostedComment(userKey: userKey, key: key, promotion: promo ) { result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                   
                    if model.code == "200" {
                        self.view.stopLoading()
                        self.commentInfo = model.result!
                        let contentOffset = self.tableview.contentOffset
                        self.tableview.reloadData()
                        self.tableview.layoutIfNeeded()
                        self.tableview.setContentOffset(contentOffset, animated: false)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section > 0 && indexPath.section < commentInfo.count + 1{
            if sectionClicked != 0 && sectionClicked == indexPath.section {
                if indexPath.row != commentInfo[indexPath.section - 1].fc_replies_data!.count  {
                    let cell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.identifier) as! CommentReplyTableViewCell
//                    if postClicked == true {
//                        cell.config(commentData: fcReplies!)
//
//                    }else{
                        cell.config(commentData: (commentInfo[indexPath.section - 1].fc_replies_data?[indexPath.row])!)
//                    }
                    cell.layoutIfNeeded()
                    let size = cell.contentView.systemLayoutSizeFitting(CGSize(width: tableView.frame.width, height: UIView.layoutFittingCompressedSize.height),withHorizontalFittingPriority: .required,verticalFittingPriority: .fittingSizeLevel)
                    return size.height
                    
                }else{
                    return 60
                }
            }
        }
        let font = UIFont(name: "Poppins-Regular", size: 14)
                let constraints = CGSize(width: tableView.frame.width, height: .greatestFiniteMagnitude)
                let attributes = [NSAttributedString.Key.font: font]
                let contentSize = (feedCaption as NSString).boundingRect(
                    with: constraints,
                    options: .usesLineFragmentOrigin,
                    attributes: attributes as [NSAttributedString.Key : Any],
                    context: nil
                )
                return contentSize.height + 390
    }
}
extension FeedsCommentViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        CommentTxt.text = ""
        CommentTxt.textColor = .label
        CommentTxt.font = UIFont(name: "Poppins-Regular", size: 14)
    }
}
