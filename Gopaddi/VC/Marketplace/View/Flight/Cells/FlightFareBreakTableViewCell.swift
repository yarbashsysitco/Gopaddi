//
//  FlightFareBreakTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class FlightFareBreakTableViewCell: UITableViewCell {
    
        static let identifier = "FlightFareBreakTableViewCell"
        let backView: UIView = {
            let view = UIView()
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.systemGray2.cgColor
    //        view.layer.cornerRadius = 10
            view.backgroundColor = .tertiarySystemBackground
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let headerView: UIView = {
            let view = UIView()
            view.backgroundColor = .secondarySystemBackground
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let firstLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "15:00 "
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let secondLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "13 July, Sat"
            label.numberOfLines = 0
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(backView)
            backView.addSubview(headerView)
            headerView.addSubview(firstLabel)
            headerView.addSubview(secondLabel)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                backView.heightAnchor.constraint(equalToConstant: 70),
                
                headerView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                headerView.heightAnchor.constraint(equalToConstant: 50),
                headerView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 0),
                headerView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 0),
                
                firstLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                firstLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                
                secondLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                secondLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -15),
                
            ])
        }
        
        func configure(firstname : String ,secondname : String) {
            firstLabel.text = firstname
            secondLabel.text = secondname
            
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }

