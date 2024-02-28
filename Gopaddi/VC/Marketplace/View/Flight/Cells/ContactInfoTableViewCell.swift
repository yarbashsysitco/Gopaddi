//
//  ContactInfoTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//
import UIKit
import iOSDropDown
class ContactInfoTableViewCell: UITableViewCell {

                static let identifier = "ContactInfoTableViewCell"

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
                    label.text = "CONTACT DETAILS"
                    label.font = UIFont(name: "Poppins-Regular", size: 15)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    return label
                }()
                let dropDownSur = DropDown()
                   let surNameTF: UITextField = {
                        let field =  TextFieldWithPadding()
                        field.layer.borderWidth = 0.1
                        field.autocorrectionType = .yes
                        field.autocapitalizationType = .none
                        field.layer.cornerRadius = 10
                        field.textColor = .label
                       field.font = UIFont(name: "Poppins-Regular", size: 14)
                        field.layer.borderWidth = 1.0
                        field.layer.borderColor = UIColor.systemGray.cgColor
                        field.backgroundColor = .tertiarySystemBackground
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
                        field.font = UIFont(name: "Poppins-Regular", size: 14)
                        field.layer.borderColor = UIColor.systemGray.cgColor
                        field.backgroundColor = .tertiarySystemBackground
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
                    field.font = UIFont(name: "Poppins-Regular", size: 14)
                        field.layer.borderColor = UIColor.systemGray.cgColor
                        field.backgroundColor = .tertiarySystemBackground
                        field.placeholder = "Last name"
                        field.translatesAutoresizingMaskIntoConstraints = false
                        return field
                    }()
            let middleNameTF: UITextField = {
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
                field.placeholder = "Middle name"
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
        private let prefixTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray.cgColor
            field.backgroundColor = .tertiarySystemBackground
            field.setupRightView(imageViewNamed: "down")
            field.placeholder = "+996"
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
            let emailTF: UITextField = {
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
                field.placeholder = "Email ID"
                field.translatesAutoresizingMaskIntoConstraints = false
                return field
            }()
               
                    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                        super.init(style: style, reuseIdentifier: reuseIdentifier)
                    
                        contentView.backgroundColor = .systemBackground
                                contentView.addSubview(headerView)
                                headerView.addSubview(contactLabel)
                                headerView.addSubview(surNameTF)
                        headerView.addSubview(middleNameTF)
                        headerView.addSubview(prefixTF)
                        headerView.addSubview(phTF)
                        headerView.addSubview(emailTF)
            //                    dropDownView.addSubview(dropDownSur)
                                headerView.addSubview(firstNameTF)
                                headerView.addSubview(lastNameTF)
            //                    dropDownSur.optionArray = ["Mr", "Mrs"]
            //            dropDownSur.placeholder = "Mr/Mrs"
            //            dropDownSur.didSelect{(selectedText , index ,id) in
            //            self.dropDownSur.text = "Selected String: \(selectedText) \n index: \(index)"
            //                }
                    }

                    override func layoutSubviews() {
                        super.layoutSubviews()
                        NSLayoutConstraint.activate([
                        
                                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                                    headerView.heightAnchor.constraint(equalToConstant: 400),
                               
                                    contactLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
                                    contactLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                                    
                                    surNameTF.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 57),
                                    surNameTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                    surNameTF.heightAnchor.constraint(equalToConstant: 48),
                                    surNameTF.widthAnchor.constraint(equalToConstant: 100),
                                    
            //                        dropDownSur.centerXAnchor.constraint(equalTo: dropDownView.centerXAnchor),
            //                        dropDownSur.centerYAnchor.constraint(equalTo: dropDownView.centerYAnchor),
            //                        dropDownSur.heightAnchor.constraint(equalToConstant: 45),
            //                        dropDownSur.widthAnchor.constraint(equalToConstant: 100),
                        
                                    firstNameTF.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 57),
                                    firstNameTF.leadingAnchor.constraint(equalTo: surNameTF.trailingAnchor, constant: 15),
                                    firstNameTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant:  -16),
                                    firstNameTF.heightAnchor.constraint(equalToConstant: 48),
                        
                                    lastNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 16),
                                    lastNameTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                    lastNameTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                    lastNameTF.heightAnchor.constraint(equalToConstant: 48),
                                    
                                    middleNameTF.topAnchor.constraint(equalTo: lastNameTF.bottomAnchor, constant: 16),
                                    middleNameTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                    middleNameTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                    middleNameTF.heightAnchor.constraint(equalToConstant: 48),
                                    
                                    prefixTF.topAnchor.constraint(equalTo:middleNameTF.bottomAnchor, constant: 16),
                                    prefixTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                    prefixTF.heightAnchor.constraint(equalToConstant: 48),
                                    prefixTF.widthAnchor.constraint(equalToConstant: 130),
                                    
                                    phTF.topAnchor.constraint(equalTo: middleNameTF.bottomAnchor, constant: 16),
                                    phTF.leadingAnchor.constraint(equalTo: prefixTF.trailingAnchor, constant: 16),
                                    phTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                    phTF.heightAnchor.constraint(equalToConstant: 48),
                                    
                                    emailTF.topAnchor.constraint(equalTo: phTF.bottomAnchor, constant: 16),
                                    emailTF.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                                    emailTF.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                                    emailTF.heightAnchor.constraint(equalToConstant: 48),
                                ])
                    }
                   
                    required init?(coder: NSCoder) {
                        fatalError("init(coder:) has not been implemented")
                    }
                    
                }
