//
//  PostRepliesTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 06/06/23.
//

import UIKit

class PostRepliesTableViewCell: UITableViewCell{
    static let identifier = "PostRepliesTableViewCell"
    var post : (() -> ())?
    let headerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        field.autocapitalizationType = .sentences
        field.textColor = .systemGray
        field.text = "Add Comments..."
        field.font = UIFont(name: "Poppins-Regular", size: 14)
        field.backgroundColor = .systemBackground
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentTF.delegate = self
       
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerView)
        headerView.addSubview(commentTF)
        headerView.addSubview(postButton)
        commentTF.delegate = self
        selectionStyle = .none
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    @objc func didTapPostButton(){
        post?()

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            headerView.heightAnchor.constraint(equalToConstant: 48),

        commentTF.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        commentTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 10),
        commentTF.trailingAnchor.constraint(equalTo: postButton.leadingAnchor),
        commentTF.heightAnchor.constraint(equalToConstant: 43),

        postButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        postButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
        postButton.widthAnchor.constraint(equalToConstant: 48),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension PostRepliesTableViewCell : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentTF.text = ""
        commentTF.textColor = .label
    }
}
