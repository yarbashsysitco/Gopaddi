//
//  TravellerInfoTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit
import iOSDropDown

class TravellerInfoTableViewCell: UITableViewCell {
    
    static let identifier = "TravellerInfoTableViewCell"
    
    let headerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    let contactLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font =  UIFont(name: "Poppins-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let sirNameTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 7
        field.textColor = .label
        field.layer.borderWidth = 1.0
        field.font =  UIFont(name: "Poppins-Regular", size: 13)
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "Mr/Mrs"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let firstNameTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 7
        field.textColor = .label
        field.layer.borderWidth = 1.0
        field.font =  UIFont(name: "Poppins-Regular", size: 13)
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "First name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let lastNameTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 7
        field.textColor = .label
        field.layer.borderWidth = 1.0
        field.font =  UIFont(name: "Poppins-Regular", size: 13)
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "Last name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let drop: DropDown = {
        let drop =  DropDown()
        drop.layer.borderWidth = 0.1
        drop.autocorrectionType = .yes
        drop.autocapitalizationType = .none
        drop.layer.cornerRadius = 7
        drop.textAlignment = .center
        drop.arrowColor = .systemBackground
        drop.textColor = .label
        drop.layer.borderWidth = 1.0
        drop.font =  UIFont(name: "Poppins-Regular", size: 13)
        drop.layer.borderColor = UIColor.systemGray.cgColor
        drop.backgroundColor = .secondarySystemBackground
        drop.placeholder = "Title"
        drop.arrowSize = 10
        drop.translatesAutoresizingMaskIntoConstraints = false
        return drop
    }()
    var childTitle = ["Master", "Miss"]
    var adultTitle = ["Mr", "Mrs"]
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(headerView)
        headerView.addSubview(contactLabel)
        headerView.addSubview(drop)
        headerView.addSubview(firstNameTF)
        headerView.addSubview(lastNameTF)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            contactLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            contactLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            
            drop.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 57),
            drop.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            drop.heightAnchor.constraint(equalToConstant: 48),
            drop.widthAnchor.constraint(equalToConstant: 100),
            
            firstNameTF.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 57),
            firstNameTF.leadingAnchor.constraint(equalTo: drop.trailingAnchor, constant: 15),
            firstNameTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant:  -16),
            firstNameTF.heightAnchor.constraint(equalToConstant: 48),
            
            lastNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 16),
            lastNameTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            lastNameTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            lastNameTF.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

