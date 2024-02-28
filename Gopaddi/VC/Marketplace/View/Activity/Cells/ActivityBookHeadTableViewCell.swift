//
//  ActivityBookHeadTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit

class ActivityBookHeadTableViewCell: UITableViewCell {

        static let identifier = "ActivityBookHeadTableViewCell"
        
        let headerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            return view
        }()
    let lineView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()
    let lineView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Checkout"
            label.textColor = .label
            label.font =  UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let tourImageView: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.clipsToBounds = true
            image.layer.masksToBounds = true
            image.layer.cornerRadius = 8
            return image
        }()
        let nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font =  UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let dateLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let timeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let adultLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let childLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let adultLabell: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let childLabell: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let totalLabell: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "Total:"
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let adultPriceLabell: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let childPriceLabell: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let totalPriceLabell: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
       
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.backgroundColor = .systemBackground
            contentView.addSubview(headerView)
            headerView.addSubview(titleLabel)
            headerView.addSubview(lineView1)
            headerView.addSubview(lineView2)
            headerView.addSubview(tourImageView)
            headerView.addSubview(nameLabel)
            headerView.addSubview(dateLabel)
            headerView.addSubview(timeLabel)
            headerView.addSubview(adultLabel)
            headerView.addSubview(childLabel)
            headerView.addSubview(adultLabell)
            headerView.addSubview(childLabell)
            headerView.addSubview(totalLabell)
            headerView.addSubview(adultPriceLabell)
            headerView.addSubview(childPriceLabell)
            headerView.addSubview(totalPriceLabell)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                
                headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                headerView.heightAnchor.constraint(equalToConstant: 280),
                
                titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                
                tourImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
                tourImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                tourImageView.widthAnchor.constraint(equalToConstant: 120),
                tourImageView.heightAnchor.constraint(equalToConstant: 120),
                
                lineView1.topAnchor.constraint(equalTo: tourImageView.bottomAnchor, constant: 10),
                lineView1.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                lineView1.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                lineView1.heightAnchor.constraint(equalToConstant: 1),
                
                nameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 71),
                nameLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: 16),
                nameLabel.widthAnchor.constraint(equalToConstant: headerView.frame.width - 160),
                
                dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
                dateLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: 16),
                
                timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
                timeLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: 16),
                
                adultLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
                adultLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: 16),
                
                childLabel.topAnchor.constraint(equalTo: adultLabel.bottomAnchor, constant: 4),
                childLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: 16),
                
                adultLabell.topAnchor.constraint(equalTo: tourImageView.bottomAnchor, constant: 20),
                adultLabell.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                
                childLabell.topAnchor.constraint(equalTo: adultLabell.bottomAnchor, constant: 16),
                childLabell.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                
                totalLabell.topAnchor.constraint(equalTo: childLabell.bottomAnchor, constant: 16),
                totalLabell.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                
                adultPriceLabell.topAnchor.constraint(equalTo: tourImageView.bottomAnchor, constant: 20),
                adultPriceLabell.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
                
                childPriceLabell.topAnchor.constraint(equalTo: adultPriceLabell.bottomAnchor, constant: 16),
                childPriceLabell.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
                
                totalPriceLabell.topAnchor.constraint(equalTo: childPriceLabell.bottomAnchor, constant: 16),
                totalPriceLabell.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
                
                lineView2.topAnchor.constraint(equalTo: totalPriceLabell.bottomAnchor, constant: 10),
                lineView2.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                lineView2.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                lineView2.heightAnchor.constraint(equalToConstant: 1),
                
            ])
        }
    func configure (activityDetailsResult : [ActivityDetailsResult] ,index : Int , date : String){
            
            tourImageView.sd_setImage(with: URL(string: activityDetailsResult[0].featuredImage))
            nameLabel.text =  activityDetailsResult[0].ActivityName
            adultLabel.text =  String( activityDetailsResult[0].adultNo) + " Adult(s)"
            childLabel.text = (activityDetailsResult[0].childNo) + " Children"
            timeLabel.text = date
            adultLabell.text = String( activityDetailsResult[0].adultNo) + " Adult(s)"
            childLabell.text = (activityDetailsResult[0].childNo) + " Children"
            totalPriceLabell.text = String(round(activityDetailsResult[0].activityPriceArray[index].totalPrice) * 100 / 100)
            adultPriceLabell.text = String(round(activityDetailsResult[0].activityPriceArray[index].adultPrice) * 100 / 100)
            childPriceLabell.text = String(round(activityDetailsResult[0].activityPriceArray[index].childPrice) * 100 / 100)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }



