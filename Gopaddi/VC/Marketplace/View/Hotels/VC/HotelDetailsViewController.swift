//
//  HotelDetailsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit


class HotelDetailsViewController: UIViewController {
        var hotelDetailsResult : [HotelDetailsResult]?
        var activityId: String = String()
        var searchId = String()
        var sessionId = String()
        var rooms = String()
        var productID = String()
        var hotelID = String()
        var activityCode = String()
        var imageUrl = String()
        var name = String()
        var night = String()
        var date = String()
        var dateApi = String()
        
        var count : Int?
        
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.separatorStyle = .none
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(HotelDetailsHeadTableViewCell.self, forCellReuseIdentifier: HotelDetailsHeadTableViewCell.identifier)
            tableView.register(HotelDetailsSecondHeadTableViewCell.self, forCellReuseIdentifier: HotelDetailsSecondHeadTableViewCell.identifier)
            tableView.register(HotelDetailTableViewCell.self, forCellReuseIdentifier: HotelDetailTableViewCell.identifier)
            return tableView
        }()
 
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            title = "Hotel"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
        @objc private func didTapBackButton(){
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    extension HotelDetailsViewController : UITableViewDelegate , UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 2 {
                return "Room rates"
            }
            return ""
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section  {
            case 0 : return 1
            case 1 : return 1
            case 2 : return hotelDetailsResult?[0].hotelDetails[0].roomrates.count ?? 0
            default : print("Invalid")
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelDetailsHeadTableViewCell.identifier, for: indexPath) as? HotelDetailsHeadTableViewCell else {
                    return UITableViewCell()}
                cell.configure(image: imageUrl , name: name, imageList: (hotelDetailsResult?[0].hotelDetails[indexPath.row].images) ?? [])
                return cell
            }
            if indexPath.section == 1{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelDetailsSecondHeadTableViewCell.identifier, for: indexPath) as? HotelDetailsSecondHeadTableViewCell else {
                    return UITableViewCell()}
                cell.configure(location: hotelDetailsResult?[0].hotelDetails[0].location ?? "", rateValue: Double(hotelDetailsResult?[0].hotelDetails[0].rating ?? "0") ?? 0)
               
                return cell
            }
            if indexPath.section == 2{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelDetailTableViewCell.identifier, for: indexPath) as? HotelDetailTableViewCell else {
                    return UITableViewCell()}
                cell.configureText(name: hotelDetailsResult?[0].hotelDetails[0].roomrates[indexPath.row].roomType ?? "", amount: hotelDetailsResult?[0].hotelDetails[0].roomrates[indexPath.row].netPrice ?? 0, currency : hotelDetailsResult?[0].hotelDetails[0].roomrates[indexPath.row].currency ?? "")
                return cell
            }
            
            return UITableViewCell()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 330
            }
            if indexPath.section == 1 {
                return 120
            }
            if indexPath.section == 2 {
                return 200
            }
            
            return 0
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 2{
                let vc = HotelConfirmViewController()
                vc.searchID = searchId
               vc.indexPathRow = indexPath.row
                vc.hotelDetails = hotelDetailsResult?[0].hotelDetails
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                self.present(navVC, animated: true)
            }
        }
    }


