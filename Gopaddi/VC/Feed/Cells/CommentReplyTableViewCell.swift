//
//  CommentReplyTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 30/05/23.
//

import UIKit
import SDWebImage
class CommentReplyTableViewCell: UITableViewCell {

    static let identifier = "CommentReplyTableViewCell"
    let contView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 3
//        view.backgroundColor = .systemGray5
//        view.layer.shadowOpacity = 2
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
        return view
    }()
    private let commentCreatorPic: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 12.5
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .systemBlue
        return imageview
    }()
    let Likes: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Likes"
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let noOfLikes: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let createdAt: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let caption: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 20
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let commentCreatorName: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let likeButton: UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
//    private let replyButton: UIButton = {
//        let button =  UIButton()
//        button.setTitle("Reply", for: .normal)
//        button.setTitleColor(UIColor.systemGray, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
//        button.isUserInteractionEnabled = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    let emojiButton: UIButton = {
//        let button =  UIButton()
//        button.setImage(UIImage(named: "emoji0"),for: .normal)
//        button.isUserInteractionEnabled = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    let emojiCountlabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .systemGray
//        label.text = "0"
//        label.font = UIFont(name: "Poppins-Regular", size: 12)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    let emojiButton: UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(named: "emoji0"),for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let emojiCountlabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "0"
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

            var replyComment : (() -> ())?
            var postReply : (() -> ())?
    var likeClicked : (() -> ())?
            override func awakeFromNib() {
                super.awakeFromNib()
                
            }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(commentCreatorPic)
        contentView.addSubview(contView)
//        contView.addSubview(noOfLikes)
        contView.addSubview(emojiCountlabel)
        contView.addSubview(createdAt)
        contView.addSubview(caption)
        contView.addSubview(emojiButton)
        contView.addSubview(commentCreatorName)
//        contView.addSubview(replyButton)
//        contView.addSubview(emojiButton)
//        contView.addSubview(emojiCountlabel)
        selectionStyle = .none
//        likeButton.addTarget(self, action: #selector(didTapLikeBtn), for: .touchUpInside)
//        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            commentCreatorPic.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            commentCreatorPic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            commentCreatorPic.heightAnchor.constraint(equalToConstant: 25),
            commentCreatorPic.widthAnchor.constraint(equalToConstant: 25),

            contView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            contView.leadingAnchor.constraint(equalTo: commentCreatorPic.trailingAnchor, constant: 0),
            contView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            contView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            commentCreatorName.topAnchor.constraint(equalTo: contView.topAnchor, constant: 5),
            commentCreatorName.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: 15),
            commentCreatorName.heightAnchor.constraint(equalToConstant: 20),

            caption.topAnchor.constraint(equalTo: commentCreatorName.bottomAnchor, constant: 5),
            caption.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: 15),
            caption.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -5),
            caption.bottomAnchor.constraint(equalTo: createdAt.topAnchor, constant: 0),
            
//            replyButton.topAnchor.constraint(equalTo: caption.bottomAnchor,constant: 0),
//            replyButton.leadingAnchor.constraint(equalTo: contView.leadingAnchor,constant: 15),
//            replyButton.heightAnchor.constraint(equalToConstant: 20),
//            replyButton.widthAnchor.constraint(equalToConstant: 40),
//
//            emojiCountlabel.trailingAnchor.constraint(equalTo: emojiButton.leadingAnchor,constant: -5),
//            emojiCountlabel.heightAnchor.constraint(equalToConstant: 25),
//            emojiCountlabel.topAnchor.constraint(equalTo: caption.topAnchor,constant: 0),
//
//            emojiButton.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -5),
//            emojiButton.widthAnchor.constraint(equalToConstant: 40),
//            emojiButton.heightAnchor.constraint(equalToConstant: 25),
//            emojiButton.topAnchor.constraint(equalTo: caption.topAnchor,constant: 0),
            

            createdAt.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: 15),
            createdAt.widthAnchor.constraint(equalToConstant: 150),
            createdAt.bottomAnchor.constraint(equalTo: contView.bottomAnchor, constant: -15),

            emojiCountlabel.trailingAnchor.constraint(equalTo: emojiButton.leadingAnchor, constant: -1),
            emojiCountlabel.bottomAnchor.constraint(equalTo: contView.bottomAnchor, constant: -20),

//            noOfLikes.leadingAnchor.constraint(equalTo: Likes.trailingAnchor, constant: 0),
//            noOfLikes.bottomAnchor.constraint(equalTo: contView.bottomAnchor, constant: -15),

            emojiButton.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -15),
            emojiButton.widthAnchor.constraint(equalToConstant: 50),
            emojiButton.heightAnchor.constraint(equalToConstant: 25),
            emojiButton.bottomAnchor.constraint(equalTo: contView.bottomAnchor, constant: -15),

        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTapReply(){
        replyComment?()
    }
   
            @objc func didTapLikeBtn(_ sender: Any) {
                likeClicked?()
            }
            func config(commentData : FcRepliesDatum){
                    if  commentData.fc_liked == 1{
//                      likeButton.tintColor = .systemBlue
                }else{
//                    likeButton.tintColor = .systemGray
                }
//                noOfLikes.text = "(" + String(commentData.fc_likes!) + ")"
                if let url = commentData.fc_commentor?[0].us_picture {
                    commentCreatorPic.sd_setImage(with: URL(string:  url))
                }
                caption.text = commentData.fc_comment
                commentCreatorName.text = commentData.fc_commentor?[0].us_name
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let postedTimeString = commentData.fc_created_at!
                guard let postedTime = dateFormatter.date(from: postedTimeString) else {
                    print("Failed to convert the posted time string to a Date object.")
                    return
                }
//                let presentTime = Date()
//                let calendar = Calendar.current
//                let components = calendar.dateComponents([.year, .day, .hour, .minute,.second], from: postedTime, to: presentTime)
//                let years = components.year ?? 0
//                let days = components.day ?? 0
//                let hours = components.hour ?? 0
//                let minutes = components.minute ?? 0
//                let seconds = components.second ?? 0

//                if years == 0 {
//                    if days != 0{
//                        createdAt.text = String(days) + " days ago"
//                    }else if hours != 0 {
//                        createdAt.text = String(hours) + " hours ago"
//                    }
//                else if minutes != 0{
//                    createdAt.text = String(minutes) + " minutes ago"
//                } else if seconds != 0{
//                    createdAt.text = String(minutes) + " Seconds ago"
//                }else{
//                    createdAt.text = " Just now"
//                }
//                }else{
//                    createdAt.text = String(years) + " years ago"
//                }
                
            }
         
        }


