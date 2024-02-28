//
//  ActivityBookingSelectViewController.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import UIKit

class ActivityBookingSelectViewController: UIViewController {
            let option = ["Visa Booking","Vacation Package Booking","Activity Booking","Hotel Booking"]
            var sortValue : String = " "
            var delegate : Category?
            private let contentView : UIView = {
                let view = UIView()
                view.layer.cornerRadius = 10
                view.layer.borderWidth = 1
                view.layer.borderColor = UIColor.systemGray2.cgColor
                view.backgroundColor = .secondarySystemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            private let titleLabel: UILabel = {
                let label = UILabel()
                label.text = "Select Booking Type"
                label.textColor = .label
                label.textAlignment = .center
                label.font = UIFont(name: "Poppins-Regular", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let closeButton: UIButton = {
                let button = UIButton()
                button.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.imageView?.tintColor = .systemGray
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()
            private let tableView: UITableView = {
                let tableView = UITableView()
                tableView.separatorStyle = .none
                tableView.backgroundColor = .systemBackground
                tableView.register(ActivityBookingSelectTableViewCell.self, forCellReuseIdentifier: ActivityBookingSelectTableViewCell.identifier)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                return tableView
            }()
            override func viewDidLoad() {
                super.viewDidLoad()
                view.addSubview(contentView)
                contentView.addSubview(titleLabel)
                contentView.addSubview(closeButton)
                contentView.addSubview(tableView)
                tableView.delegate = self
                tableView.dataSource = self
                closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
               
            }
        
            @objc func didTapClose(){
                self.dismiss(animated: true)
            }
            override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                NSLayoutConstraint.activate([
                    
                    contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    contentView.heightAnchor.constraint(equalToConstant: 300),
                    
                    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                    
                    closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10 ),
                    closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    closeButton.heightAnchor.constraint(equalToConstant: 30),
                    closeButton.widthAnchor.constraint(equalToConstant: 30),
                    
                    tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                    tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    
                ])
            }
            @objc private func tappedDone() {
                self.dismiss(animated: true)
            }
        }
        extension ActivityBookingSelectViewController: UITableViewDelegate, UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return option.count
            }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityBookingSelectTableViewCell.identifier, for: indexPath) as? ActivityBookingSelectTableViewCell else {
                    return UITableViewCell()
                }

                let optedItem = option[indexPath.row]
                cell.configureText(text: optedItem)
                
                return cell
            }
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                delegate?.categorySelected(category: indexPath.row + 1)
                self.dismiss(animated: true)
            }
        }
