//
//  FlightDetAmountTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class FlightDetAmountTableViewCell: UITableViewCell {

            static let identifier = "FlightDetAmountTableViewCell"
            let headerView: UIView = {
                let view = UIView()
                view.backgroundColor = .secondarySystemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            let totalLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "900 NGN"
                label.font = UIFont(name: "Poppins-SemiBold", size: 20)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
        let dotLabel: UILabel = {
            let label = UILabel()
            label.textColor = .systemBlue
            label.text = "."
            label.numberOfLines = 0
            label.font = UIFont(name: "Poppins-SemiBold", size: 35)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
            let timeLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "1h 10min"
                label.numberOfLines = 0
                label.font = UIFont(name: "Poppins-Regular", size: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
        private let buyButton: UIButton = {
            let button =  UIButton()
            button.layer.borderWidth = 0.1
            button.layer.cornerRadius = 10
            button.setTitle("Buy", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
            button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
            button.isUserInteractionEnabled = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                contentView.addSubview(headerView)
                headerView.addSubview(totalLabel)
                headerView.addSubview(timeLabel)
                headerView.addSubview(dotLabel)
                headerView.addSubview(buyButton)
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                    headerView.heightAnchor.constraint(equalToConstant: 100),
                    
                    totalLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    totalLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                    
                    dotLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 15),
                    dotLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 15),
                    
                    timeLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    timeLabel.leadingAnchor.constraint(equalTo: dotLabel.trailingAnchor,constant: 15),
                    
                    buyButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    buyButton.heightAnchor.constraint(equalToConstant: 48),
                    buyButton.widthAnchor.constraint(equalToConstant: 100),
                    buyButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: 0),
                    
                ])
            }
            
            func configure(firstname : String ,secondname : String) {
               
                
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            
        }

