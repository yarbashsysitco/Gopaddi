//
//  CommentsTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 01/06/23.
//
import UIKit
import SDWebImage
class CommentsTableViewCell: UITableViewCell {

    static let identifier = "CommentsTableViewCell"
    let contView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 3
//        view.backgroundColor = .secondarySystemBackground
        view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
        return view
    }()
    let footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .secondarySystemBackground
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
        label.font = UIFont(name: "Poppins-Regular", size: 12)
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
    let emojiButton: UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(systemName: "bolt.circle.fill"), for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let replyButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Reply", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let noOfReply: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var replyComment : (() -> ())?
    var likeBtn : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(commentCreatorPic)
        contentView.addSubview(contView)
        contView.addSubview(commentCreatorName)
        contView.addSubview(footerView)
        contView.addSubview(caption)
        footerView.addSubview(noOfLikes)
        footerView.addSubview(Likes)
        footerView.addSubview(createdAt)
        footerView.addSubview(likeButton)
        footerView.addSubview(emojiButton)
        footerView.addSubview(replyButton)
        footerView.addSubview(noOfReply)
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
    }
    @objc func didTapReply(){
        replyComment?()
    }
    @objc func didTapLike(){
        likeBtn?()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            commentCreatorPic.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            commentCreatorPic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            commentCreatorPic.heightAnchor.constraint(equalToConstant: 25),
            commentCreatorPic.widthAnchor.constraint(equalToConstant: 25),

            contView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            contView.leadingAnchor.constraint(equalTo: commentCreatorPic.trailingAnchor, constant: 0),
            contView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            contView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),

            commentCreatorName.topAnchor.constraint(equalTo: contView.topAnchor, constant: 10),
            commentCreatorName.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: 15),
            commentCreatorName.heightAnchor.constraint(equalToConstant: 15),

            caption.topAnchor.constraint(equalTo: commentCreatorName.bottomAnchor, constant: 5),
            caption.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: 15),
            caption.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -10),
            caption.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -10),


            footerView.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: 0),
            footerView.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -5),
            footerView.bottomAnchor.constraint(equalTo: contView.bottomAnchor, constant: 5),
            footerView.heightAnchor.constraint(equalToConstant: 40),

            createdAt.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 15),
            createdAt.widthAnchor.constraint(equalToConstant: 150),
            createdAt.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            Likes.leadingAnchor.constraint(equalTo: createdAt.trailingAnchor, constant: 0),
            Likes.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            noOfLikes.leadingAnchor.constraint(equalTo: Likes.trailingAnchor, constant: 2),
            noOfLikes.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            replyButton.leadingAnchor.constraint(equalTo: noOfLikes.trailingAnchor, constant: 10),
            replyButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            noOfReply.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: 2),
            noOfReply.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            likeButton.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -50),
            likeButton.widthAnchor.constraint(equalToConstant: 25),
            likeButton.heightAnchor.constraint(equalToConstant: 25),
            likeButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            
            ///////////////////
            
//            likeButton.trailingAnchor.constraint(equalTo: emojiButton.leadingAnchor, constant: -10),
//            likeButton.widthAnchor.constraint(equalToConstant: 25),
//            likeButton.heightAnchor.constraint(equalToConstant: 25),
//            likeButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            emojiButton.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -20),
            emojiButton.widthAnchor.constraint(equalToConstant: 25),
            emojiButton.heightAnchor.constraint(equalToConstant: 25),
            emojiButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            
          

        ])

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(commentData : ResponseInfo){
        if commentData.fc_liked == 0{
            likeButton.tintColor = .systemGray
        }else{
            likeButton.tintColor = .systemBlue
        }
        if let url = commentData.fc_commentor?[0].us_picture {
            commentCreatorPic.sd_setImage(with: URL(string:  url))
        }
        noOfReply.text = "(" + String(commentData.fc_replies) + ")"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let postedTimeString = commentData.fc_created_at!
        guard let postedTime = dateFormatter.date(from: postedTimeString) else {
            print("Failed to convert the posted time string to a Date object.")
            return
        }
        let presentTime = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .day, .hour, .minute,.second], from: postedTime, to: presentTime)
        let years = components.year ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0

        if years == 0 {
            if days != 0{
                createdAt.text = String(days) + " days ago"
            }else if hours != 0 {
                createdAt.text = String(hours) + " hours ago"
            }
        else if minutes != 0{
            createdAt.text = String(minutes) + " minutes ago"
        } else if seconds != 0{
            createdAt.text = String(minutes) + " Seconds ago"
        }else{
            createdAt.text = " Just now"
        }
        }else{
            createdAt.text = String(years) + " years ago"
        }

//        createdAt.text = commentData.fc_created_at
        caption.text = commentData.fc_comment
        commentCreatorName.text = commentData.fc_commentor?[0].us_name
        noOfLikes.text = "(" + String(commentData.fc_likes!) + ")"
    }


}

