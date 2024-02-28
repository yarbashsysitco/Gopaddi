//
//  ActivityBookListTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import UIKit
import SDWebImage
class ActivityBookListTableViewCell: UITableViewCell {
        static let identifier = "ActivityBookListTableViewCell"
        let headerView: UIView = {
            let view = UIView()
            view.backgroundColor = .tertiarySystemBackground
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
            label.font = UIFont(name: "Poppins-Medium", size: 16)
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
            label.textAlignment = .left
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let detailButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("See Details", for: .normal)
            button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
            return button
        }()
        
        var didTap : (() ->())?
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.layer.shadowOffset = CGSize(width: 0.4, height: 0.3)
            contentView.layer.shadowRadius = 0.6
            contentView.layer.shadowOpacity = 0.4
            contentView.addSubview(headerView)
            headerView.addSubview(headerImageView)
            headerView.addSubview(titleLabel)
            headerView.addSubview(lineView1)
            headerView.addSubview(priceLabel)
            headerView.addSubview(dutationLabel)
            headerView.addSubview(detailButton)
            detailButton.addTarget(self, action: #selector(didTapDetails), for: .touchUpInside)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                
                headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
                headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                headerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                headerImageView.heightAnchor.constraint(equalToConstant: 180),
                
                titleLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -16),
                
                lineView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                lineView1.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                lineView1.trailingAnchor.constraint(equalTo: headerView.trailingAnchor ,constant: -16),
                lineView1.heightAnchor.constraint(equalToConstant: 1),
                
                dutationLabel.topAnchor.constraint(equalTo: lineView1.topAnchor, constant: 10),
                dutationLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 20),
                
                priceLabel.topAnchor.constraint(equalTo: lineView1.topAnchor, constant: 10),
                priceLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -20),
                
                detailButton.topAnchor.constraint(equalTo: dutationLabel.bottomAnchor, constant: 20),
                detailButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                detailButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                detailButton.heightAnchor.constraint(equalToConstant: 48),
                
            ])
        }
        @objc func didTapDetails(){
            didTap?()
        }
        
        func configure(activityBookingList : ActivityBookingListResult) {
            titleLabel.text = activityBookingList.activityTitle
            dutationLabel.text = activityBookingList.bookingDate
            let price = activityBookingList.totalPrice
            priceLabel.text = price + " \(activityBookingList.currency)"
            let imgUrl = activityBookingList.activityImage ?? ""
            headerImageView.sd_setImage(with: URL(string: imgUrl))
            
        }
        
        func configureHotel(BookingList : HotelBookListResult) {
            titleLabel.text = BookingList.hotelName
            dutationLabel.text = BookingList.hb_check_in + " - " + BookingList.hb_check_out
            let price = BookingList.hb_total
            priceLabel.text = price + " \(BookingList.hb_currency)"
            let imgUrl = BookingList.hotelImage ?? ""
            headerImageView.sd_setImage(with: URL(string: imgUrl))
            
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }


