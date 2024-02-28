//
//  HotelConfirmedInfoTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class HotelConfirmedInfoTableViewCell: UITableViewCell {
            var gotoHomeClicked : (() -> ())?
            static let identifier = "HotelConfirmedInfoTableViewCell"
            let headerView: UIView = {
                let view = UIView()
                view.layer.cornerRadius = 10
                view.translatesAutoresizingMaskIntoConstraints = false
                view.layer.shadowRadius = 1
                view.backgroundColor = .systemBackground
                view.layer.shadowOpacity = 1
                view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
                return view
            }()
            let contactLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "Lead Traveller Details"
                label.font = UIFont(name: "Poppins-Regular", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let NameTf: UITextField = {
                let field =  TextFieldWithPadding()
                field.layer.borderWidth = 0.1
                field.autocorrectionType = .yes
                field.autocapitalizationType = .none
                field.layer.cornerRadius = 10
                field.textColor = .label
                field.font =  UIFont(name: "Poppins-Regular", size: 14)
                field.backgroundColor = .tertiarySystemBackground
                field.layer.borderWidth = 1.0
                field.layer.borderColor = UIColor.systemGray.cgColor
                field.backgroundColor = .white
                field.placeholder = "Hotel Name"
                field.translatesAutoresizingMaskIntoConstraints = false
                return field
            }()
            let emailTf: UITextField = {
                let field =  TextFieldWithPadding()
                field.layer.borderWidth = 0.1
                field.autocorrectionType = .yes
                field.autocapitalizationType = .none
                field.layer.cornerRadius = 10
                field.textColor = .label
                field.font =  UIFont(name: "Poppins-Regular", size: 14)
                field.backgroundColor = .tertiarySystemBackground
                field.layer.borderWidth = 1.0
                field.layer.borderColor = UIColor.systemGray.cgColor
                field.backgroundColor = .white
                field.placeholder = "Email"
                field.translatesAutoresizingMaskIntoConstraints = false
                return field
            }()
        
            let numberTf: UITextField = {
                let field =  TextFieldWithPadding()
                field.layer.borderWidth = 0.1
                field.autocorrectionType = .yes
                field.autocapitalizationType = .none
                field.layer.cornerRadius = 10
                field.textColor = .label
                field.font =  UIFont(name: "Poppins-Regular", size: 14)
                field.backgroundColor = .tertiarySystemBackground
                field.layer.borderWidth = 1.0
                field.layer.borderColor = UIColor.systemGray.cgColor
                field.backgroundColor = .white
                field.placeholder = "Phone Number"
                field.translatesAutoresizingMaskIntoConstraints = false
                return field
            }()
            let bookNowButton: UIButton = {
                let button =  UIButton()
                button.layer.borderWidth = 0.1
                button.layer.cornerRadius = 10
                button.setTitle("Go To Home ", for: .normal)
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
                button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()
            let totalLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "Total"
                label.font = UIFont(name: "Poppins-Regular", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let totalTf: UITextField = {
                let field =  TextFieldWithPadding()
                field.layer.borderWidth = 0.1
                field.autocorrectionType = .yes
                field.autocapitalizationType = .none
                field.layer.cornerRadius = 10
                field.textColor = .label
                field.font =  UIFont(name: "Poppins-Regular", size: 14)
                field.backgroundColor = .tertiarySystemBackground
                field.layer.borderWidth = 1.0
                field.layer.borderColor = UIColor.systemGray.cgColor
                field.backgroundColor = .white
                field.placeholder = "Hotel Name"
                field.translatesAutoresizingMaskIntoConstraints = false
                return field
            }()
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                contentView.backgroundColor = .systemBackground
                contentView.addSubview(headerView)
                headerView.addSubview(contactLabel)
                headerView.addSubview(emailTf)
                headerView.addSubview(NameTf)
                headerView.addSubview(totalTf)
                headerView.addSubview(totalLabel)
                headerView.addSubview(numberTf)
                headerView.addSubview(bookNowButton)
                bookNowButton.addTarget(self, action: #selector(didTapGoTo), for: .touchUpInside)
            }
        
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
        
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                    headerView.heightAnchor.constraint(equalToConstant: 500),
        
                    contactLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
                    contactLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
        
                    NameTf.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 20),
                    NameTf.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                    NameTf.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                    NameTf.heightAnchor.constraint(equalToConstant: 48),
        
                    emailTf.topAnchor.constraint(equalTo: NameTf.bottomAnchor, constant: 20),
                    emailTf.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                    emailTf.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                    emailTf.heightAnchor.constraint(equalToConstant: 48),
        
                    numberTf.topAnchor.constraint(equalTo: emailTf.bottomAnchor, constant: 16),
                    numberTf.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                    numberTf.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                    numberTf.heightAnchor.constraint(equalToConstant: 48),
        
                    totalTf.topAnchor.constraint(equalTo: numberTf.bottomAnchor, constant: 16),
                totalTf.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                totalTf.heightAnchor.constraint(equalToConstant: 48),
                    totalTf.widthAnchor.constraint(equalToConstant: 120),
        
                    totalLabel.topAnchor.constraint(equalTo: numberTf.bottomAnchor, constant: 16),
                    totalLabel.trailingAnchor.constraint(equalTo: totalTf.leadingAnchor, constant: -10),
                    totalLabel.heightAnchor.constraint(equalToConstant: 48),
                    totalLabel.widthAnchor.constraint(equalToConstant: 80),
        
                    bookNowButton.topAnchor.constraint(equalTo: totalLabel   .bottomAnchor, constant: 60),
                    bookNowButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                    bookNowButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                    bookNowButton.heightAnchor.constraint(equalToConstant: 48),
                ])
            }
            @objc func didTapGoTo(){
                gotoHomeClicked?()
            }
    func config(model: ActivityRedirect){
        totalTf.text = model.result[0].totalPrice
//        NameTf.text =  model.result[0].contact[0].fname
//        numberTf.text =  model.result[0].contact[0].phone
//        emailTf.text = model.result[0].contact[0].email
    }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
        }
        
        
        
        
        
        
