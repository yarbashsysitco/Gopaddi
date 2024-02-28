//
//  FlightConfirmTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class FlightConfirmTableViewCell: UITableViewCell {
 
            static let identifier = "FlightConfirmTableViewCell"
            let headerView: UIView = {
                let view = UIView()
                view.backgroundColor = .tertiarySystemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            let firstLabel: UILabel = {
                let label = UILabel()
                label.textColor = .systemGray
                label.font = UIFont(name: "Poppins-Regular", size: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let secondLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.numberOfLines = 0
                label.font = UIFont(name: "Poppins-Regular", size: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                contentView.addSubview(headerView)
                headerView.addSubview(firstLabel)
                headerView.addSubview(secondLabel)
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                    headerView.heightAnchor.constraint(equalToConstant: 70),
                    
                    firstLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    firstLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                    
                    secondLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    secondLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -15),
                    
                ])
            }
            
        func configure(firstname : String ,secondname : String, indexpath : Int) {
            if indexpath == 5{
                firstLabel.font = UIFont(name: "Poppins-SemiBold", size: 14)
                secondLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
                firstLabel.textColor = .label
                secondLabel.textColor = .label
                
            }
            else{
                firstLabel.font = UIFont(name: "Poppins-Regular", size: 14)
                secondLabel.font = UIFont(name: "Poppins-Regular", size: 14)
                firstLabel.textColor = .systemGray
                secondLabel.textColor = .label
            }
                firstLabel.text = firstname
                secondLabel.text = secondname
                
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            
        }

