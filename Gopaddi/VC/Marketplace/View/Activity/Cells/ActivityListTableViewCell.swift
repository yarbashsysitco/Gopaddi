//
//  ActivityListTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit
import SDWebImage

class ActivityListTableViewCell: UITableViewCell {
   
        static let identifier = "ActivityListTableViewCell"
    
            let headerView: UIView = {
                let view = UIView()
                view.backgroundColor = .tertiarySystemBackground
        //        view.backgroundColor = .white
                view.layer.cornerRadius = 5
                view.layer.borderWidth = 0.1
                view.translatesAutoresizingMaskIntoConstraints = false
            
                return view
            }()
            private let lineView1 : UIView = {
                let view = UIView()
                view.backgroundColor = .systemGray
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            private let ratingView : UIView = {
                let view = UIView()
                view.backgroundColor = .red
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            let headerImageView: UIImageView = {
                let image = UIImageView()
                image.contentMode = .scaleToFill
                image.layer.masksToBounds = true
                image.clipsToBounds = true
                image.layer.cornerRadius = 5
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let titleLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.font = UIFont(name: "Poppins-Regular", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let priceLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.numberOfLines = 0
                label.font = UIFont(name: "Poppins-Regular", size: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let dutationLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.font = UIFont(name: "Poppins-Regular", size: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                contentView.layer.shadowOffset = CGSize(width: 0.4, height: 0.3)
                contentView.layer.shadowRadius = 0.6
                contentView.layer.shadowOpacity = 0.4
                contentView.addSubview(headerView)
                headerView.addSubview(headerImageView)
                headerView.addSubview(titleLabel)
                headerView.addSubview(lineView1)
//                headerView.addSubview(ratingView)
                headerView.addSubview(priceLabel)
                headerView.addSubview(dutationLabel)
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                    headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                    
                    headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
                    headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                    headerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                    headerImageView.heightAnchor.constraint(equalToConstant: 180),
                    
                    titleLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 16),
                    titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -16),
                    
//                    ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
//                    ratingView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//                    ratingView.heightAnchor.constraint(equalToConstant: 30),
                    
                
                    lineView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                    lineView1.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    lineView1.trailingAnchor.constraint(equalTo: headerView.trailingAnchor ,constant: -16),
                    lineView1.heightAnchor.constraint(equalToConstant: 1),

                    priceLabel.topAnchor.constraint(equalTo: lineView1.topAnchor, constant: 10),
                    priceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 20),
                    
                    dutationLabel.topAnchor.constraint(equalTo: lineView1.topAnchor, constant: 10),
                    dutationLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -10),
                    dutationLabel.widthAnchor.constraint(equalToConstant: 100),
                    
                ])
            }
    
            func configure(activityList : ActivityList) {
                titleLabel.text = activityList.activityName
                dutationLabel.text = activityList.duration
                let price = activityList.adultPrice
                priceLabel.text = String(round(100 * price / 100)) + "\(activityList.currency)"
                let imgUrl = activityList.featureImage
                headerImageView.sd_setImage(with: URL(string: imgUrl))
             
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            

        }


