//
//  ActivityInfoTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.

import UIKit
class ActivityInfoTableViewCell: UITableViewCell {
    var isChecked: Bool = false
    var bookClicked : (() -> ())?
    static let identifier = "ActvityInfoTableViewCell"
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    private let lineView1 : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let ImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(named: "tick")
        return imageview
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(headerView)
        headerView.addSubview(contentLabel)
        headerView.addSubview(ImageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            ImageView.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 10),
            ImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            ImageView.heightAnchor.constraint(equalToConstant: 15),
            ImageView.widthAnchor.constraint(equalToConstant: 15),
            
            contentLabel.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: 16),
        ])
    }
    func configure(content: String) {
        contentLabel.text = content
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


