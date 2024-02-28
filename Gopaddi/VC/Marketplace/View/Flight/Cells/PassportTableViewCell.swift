//
//  PassportTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class PassportTableViewCell: UITableViewCell {

                    static let identifier = "PassportTableViewCell"

                    let headerView: UIView = {
                        let view = UIView()
                        view.layer.cornerRadius = 10
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.layer.shadowRadius = 1
                        view.backgroundColor = .secondarySystemBackground
                        view.layer.shadowOpacity = 1
                        view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
                        return view
                    }()
                    let dropDownView: UIView = {
                        let view = UIView()
                        view.layer.cornerRadius = 10
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.layer.shadowRadius = 1
                        view.backgroundColor = .tertiarySystemBackground
                        view.layer.shadowOpacity = 1
                        view.layer.shadowOffset = CGSize(width: 0.6, height: 0.4)
                        return view
                    }()
                    let contactLabel: UILabel = {
                        let label = UILabel()
                        label.textColor = .label
                        label.text = "Expiry Date"
                        label.font = UIFont(name: "Poppins-Regular", size: 15)
                        label.translatesAutoresizingMaskIntoConstraints = false
                        return label
                    }()
                       
                        let dobTF: UITextField = {
                            let field =  TextFieldWithPadding()
                            field.layer.borderWidth = 0.1
                            field.autocorrectionType = .yes
                            field.autocapitalizationType = .none
                            field.layer.cornerRadius = 10
                            field.textColor = .label
                            field.layer.borderWidth = 1.0
                            field.font = UIFont(name: "Poppins-Regular", size: 14)
                            field.layer.borderColor = UIColor.systemGray.cgColor
                            field.backgroundColor = .tertiarySystemBackground
                            field.placeholder = "DD / MM / YYY"
                            field.translatesAutoresizingMaskIntoConstraints = false
                            return field
                        }()
                    let passportNoTF: UITextField = {
                            let field =  TextFieldWithPadding()
                            field.layer.borderWidth = 0.1
                            field.autocorrectionType = .yes
                            field.autocapitalizationType = .none
                            field.layer.cornerRadius = 10
                            field.textColor = .label
                            field.layer.borderWidth = 1.0
                        field.font = UIFont(name: "Poppins-Regular", size: 14)
                            field.layer.borderColor = UIColor.systemGray.cgColor
                            field.backgroundColor = .tertiarySystemBackground
                            field.placeholder = "Passport Number"
                            field.translatesAutoresizingMaskIntoConstraints = false
                            return field
                        }()
                
                let passIssueContyTF: UITextField = {
                        let field =  TextFieldWithPadding()
                        field.layer.borderWidth = 0.1
                        field.autocorrectionType = .yes
                        field.autocapitalizationType = .none
                        field.layer.cornerRadius = 10
                        field.textColor = .label
                        field.layer.borderWidth = 1.0
                    field.font = UIFont(name: "Poppins-Regular", size: 14)
                        field.layer.borderColor = UIColor.systemGray.cgColor
                        field.backgroundColor = .tertiarySystemBackground
                        field.placeholder = "Passport Issuing Country"
                        field.translatesAutoresizingMaskIntoConstraints = false
                        return field
                    }()
               
                   
                        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                            super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
                            contentView.backgroundColor = .systemBackground
                                    contentView.addSubview(headerView)
                                    headerView.addSubview(contactLabel)
                                    headerView.addSubview(dobTF)
                                    headerView.addSubview(passportNoTF)
                                    headerView.addSubview(passIssueContyTF)
                        }

                        override func layoutSubviews() {
                            super.layoutSubviews()
                            NSLayoutConstraint.activate([
                            
                                        headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                                        headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                                        headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                                        headerView.heightAnchor.constraint(equalToConstant: 250),
                                   
                                        contactLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
                                        contactLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                                       
                            
                                        dobTF.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 20),
                                        dobTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                        dobTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant:  -16),
                                        dobTF.heightAnchor.constraint(equalToConstant: 48),
                            
                                        passportNoTF.topAnchor.constraint(equalTo: dobTF.bottomAnchor, constant: 16),
                                        passportNoTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                        passportNoTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                        passportNoTF.heightAnchor.constraint(equalToConstant: 48),
                                        
                                        passIssueContyTF.topAnchor.constraint(equalTo: passportNoTF.bottomAnchor, constant: 16),
                                        passIssueContyTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                        passIssueContyTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                        passIssueContyTF.heightAnchor.constraint(equalToConstant: 48),
                                    ])
                        }
                       
                        required init?(coder: NSCoder) {
                            fatalError("init(coder:) has not been implemented")
                        }
                        
                    }
