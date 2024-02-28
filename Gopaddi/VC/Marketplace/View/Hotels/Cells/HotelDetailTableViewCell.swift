//
//  HotelDetailTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class HotelDetailTableViewCell: UITableViewCell {

        var isChecked: Bool = false
        var bookClicked : (() -> ())?
        static let identifier = "HotelDetailTableViewCell"
        let headerView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.shadowRadius = 3
            view.backgroundColor = .secondarySystemBackground
            view.layer.shadowOpacity = 2
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.systemGray2.cgColor
            view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
            return view
        }()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Medium", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let amountLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let nonRefundLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = .label
            label.text = "Non-Refundable"
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let roomOnlyLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "Room Only"
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        let maxOccLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.text = "Max Occupancy: 2.0"
            label.textColor = .label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let extraBedsLabel: UILabel = {
            let label = UILabel()
            label.font =  UIFont(name: "Poppins-Regular", size: 14)
            label.text = "Extra Beds: 0"
            label.textColor = .label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.backgroundColor = .systemBackground
            contentView.addSubview(headerView)
            headerView.addSubview(titleLabel)
            headerView.addSubview(amountLabel)
            headerView.addSubview(nonRefundLabel)
            headerView.addSubview(roomOnlyLabel)
            headerView.addSubview(maxOccLabel)
            headerView.addSubview(extraBedsLabel)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                
                headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                headerView.heightAnchor.constraint(equalToConstant: 180),
                
                titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                
                nonRefundLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                nonRefundLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                
                amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                amountLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
                
                roomOnlyLabel.topAnchor.constraint(equalTo: nonRefundLabel.bottomAnchor, constant: 10),
                roomOnlyLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                
                maxOccLabel.topAnchor.constraint(equalTo: roomOnlyLabel.bottomAnchor, constant: 10),
                maxOccLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                
                extraBedsLabel.topAnchor.constraint(equalTo: maxOccLabel.bottomAnchor, constant: 10),
                extraBedsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            ])
        }
    func configureText(name : String, amount : Double , currency : String) {
            titleLabel.text = name
             
            amountLabel.text = String(round(100 * amount / 100)) + " \(currency)"
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }




