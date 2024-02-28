//
//  FlightPassengerEntryViewController.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit
import SDWebImage

class FlightPassengerEntryViewController: UIViewController {

        let headerView: UIView = {
            let view = UIView()
            view.backgroundColor =  UIColor(red: 0.156, green: 0.482, blue: 0.878, alpha: 1)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let headInfoLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.numberOfLines = 3
            label.text = "Please enter the required information in order to book your tickets"
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let tableView : UITableView = {
            let table = UITableView()
            table.separatorStyle = .none
            table.register(PassengerTableViewCell.self , forCellReuseIdentifier: PassengerTableViewCell.identifier)
            table.register(ContactInfoTableViewCell.self , forCellReuseIdentifier: ContactInfoTableViewCell.identifier)
            table.register(DOBTableViewCell.self , forCellReuseIdentifier: DOBTableViewCell.identifier)
            table.register(PassportTableViewCell.self , forCellReuseIdentifier: PassportTableViewCell.identifier)
            table.register(FlightAmountTableViewCell.self , forCellReuseIdentifier: FlightAmountTableViewCell.identifier)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.backgroundColor = .systemBackground
            return table
        }()
        
        var email : String = ""
        var phNumber : String = ""
        var activityBookResponse :  BookingDetails?
        var activityDetailsResult = [ActivityDetailsResult]()
        override func viewDidLoad (){
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            title = "Flight"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            navigationItem.leftBarButtonItem?.tintColor = .systemBlue
            tableView.reloadData()
            view.addSubview(tableView)
            view.addSubview(headerView)
            view.addSubview(headInfoLabel)
            tableView.frame = view.bounds
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
            email  = UserDefaults.standard.string(forKey: "logemail") ?? UserDefaults.standard.string(forKey: "gemail") ?? UserDefaults.standard.string(forKey: "apEmail") ?? ""
            phNumber  = UserDefaults.standard.string(forKey: "logphone") ?? UserDefaults.standard.string(forKey: "gphone") ?? UserDefaults.standard.string(forKey: "apPhone") ?? ""
            
        }
        @objc private func didTapBackButton() {
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                headerView.heightAnchor.constraint(equalToConstant: 100),
                
                headInfoLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                headInfoLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                headInfoLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
                
                tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:     0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant:  -10)
            ])
        }
    }
    extension FlightPassengerEntryViewController : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            
            return 5
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoTableViewCell.identifier, for: indexPath) as? ContactInfoTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            if indexPath.section == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PassengerTableViewCell.identifier, for: indexPath) as? PassengerTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            if indexPath.section == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PassportTableViewCell.identifier, for: indexPath) as? PassportTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            if indexPath.section == 3 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DOBTableViewCell.identifier, for: indexPath) as? DOBTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            if indexPath.section == 4 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightAmountTableViewCell.identifier, for: indexPath) as? FlightAmountTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            return UITableViewCell()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 400
            }
            if indexPath.section == 1{
                return 270
            }
            if indexPath.section == 4{
                return 130
            }
            return 260
        }
    }

