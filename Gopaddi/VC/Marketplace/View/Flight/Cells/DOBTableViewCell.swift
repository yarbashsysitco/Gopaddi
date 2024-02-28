//
//  DOBTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class DOBTableViewCell: UITableViewCell {


                static let identifier = "DOBTableViewCell"

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
                    label.text = "Date of Birth"
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
                let nationTF: UITextField = {
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
                        field.placeholder = "Nationality"
                        field.translatesAutoresizingMaskIntoConstraints = false
                        return field
                    }()
            
            let phTF: UITextField = {
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
                    field.placeholder = "Phone Number"
                    field.translatesAutoresizingMaskIntoConstraints = false
                    return field
                }()
           
               
                    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                        super.init(style: style, reuseIdentifier: reuseIdentifier)
                    
                        contentView.backgroundColor = .systemBackground
                                contentView.addSubview(headerView)
                                headerView.addSubview(contactLabel)
                                headerView.addSubview(dobTF)
                                headerView.addSubview(nationTF)
                                headerView.addSubview(phTF)
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
                        
                                    nationTF.topAnchor.constraint(equalTo: dobTF.bottomAnchor, constant: 16),
                                    nationTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                    nationTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                    nationTF.heightAnchor.constraint(equalToConstant: 48),
                                    
                                    phTF.topAnchor.constraint(equalTo: nationTF.bottomAnchor, constant: 16),
                                    phTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                    phTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                    phTF.heightAnchor.constraint(equalToConstant: 48),
                                ])
                    }
                   
                    required init?(coder: NSCoder) {
                        fatalError("init(coder:) has not been implemented")
                    }
                    
                }
