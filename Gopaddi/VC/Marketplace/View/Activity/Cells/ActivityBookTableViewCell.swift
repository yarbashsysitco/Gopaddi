//
//  ActivityBookTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit
class ActivityBookTableViewCell: UITableViewCell {
    var isChecked: Bool = false
    var bookClicked : (() -> ())?
    static let identifier = "ActivityBookTableViewCell"
    let headerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 2
        view.backgroundColor = .secondarySystemBackground
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
        return view
    }()
    let optionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 1
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.backgroundColor = .secondarySystemBackground
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
        return view
    }()
    let headerImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.image = UIImage(systemName:"arrow.right")
        image.image?.withTintColor(.label)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.backgroundColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let adultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let childLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let bookNowButton: UIButton = {
        let button =  UIButton()
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 7
        button.setTitle("Book Now ", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(priceLabel)
        headerView.addSubview(adultLabel)
        headerView.addSubview(childLabel)
        headerView.addSubview(bookNowButton)
        headerView.addSubview(optionView)
        optionView.addSubview(titleLabel)
        optionView.addSubview(headerImageView)
        bookNowButton.addTarget(self, action: #selector(tappedBook), for: .touchUpInside)
        
    }
    @objc func tappedBook(){
        bookClicked?()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            optionView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            optionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            optionView.heightAnchor.constraint(equalToConstant: 30),
            optionView.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.centerYAnchor.constraint(equalTo: optionView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: optionView.leadingAnchor, constant: 5),
            
            headerImageView.centerYAnchor.constraint(equalTo: optionView.centerYAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            headerImageView.heightAnchor.constraint(equalToConstant: 17),
            headerImageView.widthAnchor.constraint(equalToConstant: 17),
            
            priceLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            
            childLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12),
            childLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            
            adultLabel.topAnchor.constraint(equalTo: optionView.bottomAnchor, constant: 12),
            adultLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            
            bookNowButton.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 24),
            bookNowButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            bookNowButton.heightAnchor.constraint(equalToConstant: 48),
            bookNowButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    func configureText(activityDetails: ActivityPriceArray ,cur : String) {
        titleLabel.text = activityDetails.priceTitle
        let price = Double(round(100 * activityDetails.totalPrice) / 100)
        priceLabel.text = String(price)
        let cPrice = Double(round(100 * activityDetails.childPrice) / 100)
        childLabel.text = String(cPrice)
        let aPrice = Double(round(100 * activityDetails.adultPrice) / 100)
        adultLabel.text = String(aPrice)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



