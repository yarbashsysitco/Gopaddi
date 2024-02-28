//
//  NationalityViewController.swift
//  Gopaddi
//
//  Created by jizan k on 06/02/23.
//

import UIKit

class NationalityTableViewCell: UITableViewCell {
static let identifier = "NationalityTableViewCell"
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public let countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countryImageView)
        makeConstraints()
        
    }
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            countryImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7),
            countryImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            countryImageView.widthAnchor.constraint(equalToConstant: 30),
            countryImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
