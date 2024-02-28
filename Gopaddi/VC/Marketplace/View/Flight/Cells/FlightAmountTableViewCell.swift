//
//  FlightAmountTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class FlightAmountTableViewCell: UITableViewCell {

     static let identifier = "FlightAmountTableViewCell"
        let payAmtView: UIView = {
            let view = UIView()
            view.layer.borderWidth = 0.5
            view.layer.cornerRadius = 5
            view.layer.borderColor = UIColor.systemGray.cgColor
            view.backgroundColor = .tertiarySystemBackground
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let totalLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "Total:"
            label.numberOfLines = 0
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let amtLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "AED 710.00"
            label.font = UIFont(name: "Poppins-SemiBold", size: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let payButton: UIButton = {
            let button =  UIButton()
            button.layer.borderWidth = 0.1
            button.layer.cornerRadius = 10
            button.setTitle("Pay", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
            button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
            button.isUserInteractionEnabled = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(payAmtView)
            payAmtView.addSubview(totalLabel)
            payAmtView.addSubview(payButton)
            payAmtView.addSubview(amtLabel)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            
            NSLayoutConstraint.activate([
                payAmtView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                payAmtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                payAmtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                payAmtView.heightAnchor.constraint(equalToConstant: 100),
                
                totalLabel.topAnchor.constraint(equalTo: payAmtView.topAnchor, constant: 15),
                totalLabel.leadingAnchor.constraint(equalTo: payAmtView.leadingAnchor, constant: 20),
                
                amtLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 5),
                amtLabel.leadingAnchor.constraint(equalTo: payAmtView.leadingAnchor, constant: 20),
                
                payButton.centerYAnchor.constraint(equalTo: payAmtView.centerYAnchor),
                payButton.heightAnchor.constraint(equalToConstant: 48),
                payButton.widthAnchor.constraint(equalToConstant: 150),
                payButton.trailingAnchor.constraint(equalTo: payAmtView.trailingAnchor, constant: -20),
                
            ])
        }

    }
