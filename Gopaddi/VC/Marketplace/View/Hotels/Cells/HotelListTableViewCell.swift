//
//  HotelListTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit
import Cosmos
class HotelListTableViewCell: UITableViewCell {
        static let identifier = "HotelListTableViewCell"
    let starRating = CosmosView()
            let headerView: UIView = {
                let view = UIView()
                view.backgroundColor = .tertiarySystemBackground
        //        view.backgroundColor = .white
                view.layer.cornerRadius = 10
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
                view.backgroundColor = .tertiarySystemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            let headerImageView: UIImageView = {
                let image = UIImageView()
                image.contentMode = .scaleToFill
                image.layer.masksToBounds = true
                image.clipsToBounds = true
                image.layer.cornerRadius = 10
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let titleLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.font = UIFont(name: "Poppins-SemiBold", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let priceLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.numberOfLines = 0
                label.font = UIFont(name: "Poppins-SemiBold", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let roomLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.font = UIFont(name: "Poppins-SemiBold", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let footerView: UIStackView = {
                let view = UIStackView()
                view.backgroundColor = .black.withAlphaComponent(0.5)
                view.axis = .horizontal
                view.distribution = .fillEqually
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            let footerImageView1: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named: "parking")?.withRenderingMode(.alwaysTemplate)
                image.tintColor = .white
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let footerImageView2: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named:"wifi")?.withRenderingMode(.alwaysTemplate)
                image.tintColor = .white
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let footerImageView3: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named: "service")?.withRenderingMode(.alwaysTemplate)
                image.tintColor = .white
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let footerImageView4: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named: "swimming")?.withRenderingMode(.alwaysTemplate)
                image.tintColor = .white
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let footerImageView5: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named: "gym")?.withRenderingMode(.alwaysTemplate)
                image.tintColor = .white
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let footerImageView6: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named: "bar")?.withRenderingMode(.alwaysTemplate)
                image.tintColor = .white
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
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
                headerImageView.addSubview(footerView)
                footerView.addSubview(footerImageView1)
                footerView.addSubview(footerImageView2)
                footerView.addSubview(footerImageView3)
                footerView.addSubview(footerImageView4)
                footerView.addSubview(footerImageView5)
                footerView.addSubview(footerImageView6)
                headerView.addSubview(ratingView)
                headerView.addSubview(priceLabel)
                headerView.addSubview(roomLabel)
                ratingView.addSubview(starRating)
                starRating.settings.emptyBorderWidth = 1
                starRating.settings.emptyBorderColor = .systemGray
                starRating.settings.filledBorderColor = .systemBlue
                starRating.settings.filledColor = .systemBlue
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                    headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                    
                    headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
                    headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                    headerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                    headerImageView.heightAnchor.constraint(equalToConstant: 200),
                    
                    footerView.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor),
                    footerView.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor),
                    footerView.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor),
                    footerView.heightAnchor.constraint(equalToConstant: 40),
                    
                    footerImageView1.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5),
                    footerImageView1.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant:16),
                    footerImageView1.heightAnchor.constraint(equalToConstant: 25),
                    footerImageView1.widthAnchor.constraint(equalToConstant: 25),
                    
                    footerImageView2.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5),
                    footerImageView2.leadingAnchor.constraint(equalTo: footerImageView1.trailingAnchor, constant:25),
                    footerImageView2.heightAnchor.constraint(equalToConstant: 25),
                    footerImageView2.widthAnchor.constraint(equalToConstant: 25),
                    
                    footerImageView3.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5),
                    footerImageView3.leadingAnchor.constraint(equalTo: footerImageView2.trailingAnchor, constant:25),
                    footerImageView3.heightAnchor.constraint(equalToConstant: 25),
                    footerImageView3.widthAnchor.constraint(equalToConstant: 25),
                    
                    footerImageView4.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5),
                    footerImageView4.leadingAnchor.constraint(equalTo: footerImageView3.trailingAnchor, constant:25),
                    footerImageView4.heightAnchor.constraint(equalToConstant: 25),
                    footerImageView4.widthAnchor.constraint(equalToConstant: 25),
                    
                    footerImageView5.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5),
                    footerImageView5.leadingAnchor.constraint(equalTo: footerImageView4.trailingAnchor, constant:25),
                    footerImageView5.heightAnchor.constraint(equalToConstant: 25),
                    footerImageView5.widthAnchor.constraint(equalToConstant: 25),
                    
                    footerImageView6.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5),
                    footerImageView6.leadingAnchor.constraint(equalTo: footerImageView5.trailingAnchor, constant:25),
                    footerImageView6.heightAnchor.constraint(equalToConstant: 25),
                    footerImageView6.widthAnchor.constraint(equalToConstant: 25),
                    
                    titleLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 16),
                    titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -16),
                    
                    ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
                    ratingView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    ratingView.heightAnchor.constraint(equalToConstant: 30),
                    
                    starRating.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
                    starRating.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
                    starRating.heightAnchor.constraint(equalToConstant: 30),
                    starRating.widthAnchor.constraint(equalToConstant: 140),
                
                    lineView1.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 16),
                    lineView1.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    lineView1.trailingAnchor.constraint(equalTo: headerView.trailingAnchor ,constant: -16),
                    lineView1.heightAnchor.constraint(equalToConstant: 1),

                    priceLabel.topAnchor.constraint(equalTo: lineView1.topAnchor, constant: 5),
                    priceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 20),
                    
                    roomLabel.topAnchor.constraint(equalTo: lineView1.topAnchor, constant: 5),
                    roomLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -10),
                    roomLabel.widthAnchor.constraint(equalToConstant: 200),
                    
                ])
            }
           
            func configure(hotelList : HotelList) {
                titleLabel.text = hotelList.hotelName
                let price = Double(round(100 * hotelList.totalPrice) / 100)
                priceLabel.text = String(round(100 * price / 100)) + "\(hotelList.currency)"
                roomLabel.text = hotelList.nights + " Nights  .  " + String(hotelList.rooms) + " Rooms"
                let imgUrl = hotelList.image
                headerImageView.sd_setImage(with: URL(string: imgUrl))
                starRating.rating = Double(hotelList.hotelRating) ?? 0
             
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            

        }


