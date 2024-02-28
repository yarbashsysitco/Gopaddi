//
//  HotelTravellerInfoTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class HotelTravellerInfoTableViewCell: UITableViewCell {
            static let identifier = "HotelTravellerInfoTableViewCell"

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
                label.font = .systemFont(ofSize: 16, weight: .semibold)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
               let sirNameTF: UITextField = {
                    let field =  TextFieldWithPadding()
                    field.layer.borderWidth = 0.1
                    field.autocorrectionType = .yes
                    field.autocapitalizationType = .none
                    field.layer.cornerRadius = 10
                    field.textColor = .label
                    field.layer.borderWidth = 1.0
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
                    field.layer.cornerRadius = 10
                    field.textColor = .label
                    field.layer.borderWidth = 1.0
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
                    field.layer.cornerRadius = 10
                    field.textColor = .label
                    field.layer.borderWidth = 1.0
                    field.layer.borderColor = UIColor.systemGray.cgColor
                    field.backgroundColor = .secondarySystemBackground
                    field.placeholder = "Last name"
                    field.translatesAutoresizingMaskIntoConstraints = false
                    return field
                }()
           
                override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                    super.init(style: style, reuseIdentifier: reuseIdentifier)
                
                    contentView.backgroundColor = .systemBackground
                            contentView.addSubview(headerView)
                            headerView.addSubview(contactLabel)
                            headerView.addSubview(sirNameTF)
                            headerView.addSubview(firstNameTF)
                            headerView.addSubview(lastNameTF)
                }

                override func layoutSubviews() {
                    super.layoutSubviews()
                    NSLayoutConstraint.activate([
                    
                                headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                                headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                                headerView.heightAnchor.constraint(equalToConstant: 180),
                           
                                contactLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
                                contactLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                                
                                sirNameTF.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 57),
                                sirNameTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                sirNameTF.heightAnchor.constraint(equalToConstant: 48),
                                sirNameTF.widthAnchor.constraint(equalToConstant: 100),
                    
                                firstNameTF.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 57),
                                firstNameTF.leadingAnchor.constraint(equalTo: sirNameTF.trailingAnchor, constant: 15),
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
