//
//  AcivityCancelTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 30/04/23.
//

import UIKit

class AcivityCancelTableViewCell: UITableViewCell {
    static let identifier = "AcivityCancelTableViewCell"
    let headerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    let optionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(headerView)
        headerView.addSubview(contentLabel)
        headerView.addSubview(optionLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 25),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            optionLabel.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 10),
            optionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            contentLabel.topAnchor.constraint(equalTo:optionLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
        ])
    }
    func configure(content: String , option : String) {
        optionLabel.text = option
        contentLabel.text = content
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



