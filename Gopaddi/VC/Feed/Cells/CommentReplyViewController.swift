//
//  CommentReplyViewController.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class CommentReplyViewController: UIViewController {
    
    let apiManager = ApiManager()
    var feedReplies = [ResultedData]()
    var FeedCommentLike : FeedCommentLike?
    var userName = String()
    var date = String()
    var fcId = String()
    var profileImageUrl = String()
    var feedCaption = String()
    var promo = String()
    var userKey = String()
    var key = String()
    var isReplyClicked : Bool = false
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentReplyTableViewCell.self, forCellReuseIdentifier: CommentReplyTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let commentCreatorPic: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 15
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .systemBlue
        return imageview
    }()
    private let lineView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let lineView2 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var msgLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .label
        label.numberOfLines = 10
        label.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let postButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let commentTF: UITextView = {
        let field =  UITextView()
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.textColor = .systemGray
        field.text = "Add Comments..."
        field.font = UIFont(name: "Poppins-Regular", size: 14)
        field.backgroundColor = .systemBackground
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Replies"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        view.addSubview(tableView)
        view.addSubview(msgLabel)
        view.addSubview(lineView)
        view.addSubview(lineView2)
        view.addSubview(commentTF)
        view.addSubview(postButton)
        view.addSubview(commentCreatorPic)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self
        commentTF.delegate = self
        tableView.reloadData()
        let profilePicUrl = UserDefaults.standard.string(forKey: "picture") ?? ""
        commentCreatorPic.sd_setImage(with: URL(string: profilePicUrl))
    }
    @objc func didTapBackButton(){
        self.dismiss(animated: true)
    }
    @objc func didTapPostButton(){
        if commentTF.text != "Add Comments..." {
            guard let comment = commentTF.text else { return }
        if !comment.isEmpty{
            self.apiManager.feedsComment(userKey: self.userKey, key: self.key, parent: fcId, promotion: self.promo, msg: comment){ result in
                switch result {
                case .success(let model) :
                    DispatchQueue.main.async {
                        self.commentTF.textColor = .systemGray
                        self.commentTF.text = "Add Comments..."
                        self.commentTF.resignFirstResponder()
//                        self.callReplyApi()
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    }
//    @objc func callReplyApi(){
//        let userKey = UserDefaults.standard.string(forKey: "logkey")
//        tableView.showLoading()
//        self.apiManager.feedCommentReply(userKey: userKey!, key: self.fcId){ result in
//            switch result {
//            case .success(let model) :
//                DispatchQueue.main.async {
//                    self.tableView.stopLoading()
//                    self.feedReplies = model.result!
//                    self.tableView.reloadData()
//                }
//            case .failure( let error):
//                self.tableView.stopLoading()
//                print(error.localizedDescription)
//            }
//        }
//
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            msgLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40),
            msgLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            msgLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lineView2.topAnchor.constraint(equalTo: msgLabel.bottomAnchor, constant: 10),
            lineView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView2.heightAnchor.constraint(equalToConstant: 1),
            
            commentCreatorPic.centerYAnchor.constraint(equalTo: commentTF.centerYAnchor),
            commentCreatorPic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentCreatorPic.widthAnchor.constraint(equalToConstant: 30),
            commentCreatorPic.heightAnchor.constraint(equalToConstant: 30),
            
            commentTF.topAnchor.constraint(equalTo: lineView2.bottomAnchor,constant: 15),
            commentTF.leadingAnchor.constraint(equalTo: commentCreatorPic.trailingAnchor,constant: 10),
            commentTF.trailingAnchor.constraint(equalTo: postButton.leadingAnchor),
            commentTF.heightAnchor.constraint(equalToConstant: 50),
            
            postButton.centerYAnchor.constraint(equalTo: commentTF.centerYAnchor),
            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postButton.widthAnchor.constraint(equalToConstant: 60),
            
            lineView.topAnchor.constraint(equalTo: commentTF.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension CommentReplyViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return feedReplies.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.identifier, for: indexPath) as! CommentReplyTableViewCell
//        cell.config(commentData: (feedReplies[indexPath.row]))
        cell.likeClicked = {
            print("Like Btn Clicked")
            self.apiManager.feedsCommentLike(userKey: self.userKey, key: self.feedReplies[indexPath.row].fc_id!, emoji: "", action: "like"){ result in
                switch result {
                case .success(let model) :
                    DispatchQueue.main.async {
                      if  model.liked == 1{
                            cell.likeButton.tintColor = .systemBlue
                      }else{
                          cell.likeButton.tintColor = .systemGray
                      }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.identifier) as! CommentReplyTableViewCell
//            cell.config(commentData: (feedReplies[indexPath.row]))
            cell.layoutIfNeeded()
            let size = cell.contentView.systemLayoutSizeFitting(CGSize(width: tableView.frame.width, height: UIView.layoutFittingCompressedSize.height),
                                                                withHorizontalFittingPriority: .required,
                                                                verticalFittingPriority: .fittingSizeLevel)
            return size.height
        }
        return 0
    }
}
extension CommentReplyViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentTF.text = ""
        commentTF.textColor = .label
    }
}
