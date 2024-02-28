//
//  HotelConfirmPreviewViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit
import iOSDropDown

class HotelConfirmPreviewViewController: UIViewController {
        private let tableView : UITableView = {
            let table = UITableView()
            table.separatorStyle = .none
            table.register(HotelConfirmedInfoTableViewCell.self , forCellReuseIdentifier: HotelConfirmedInfoTableViewCell.identifier)
            table.register(HotelConfirmPreviewHeadTableViewCell.self , forCellReuseIdentifier: HotelConfirmPreviewHeadTableViewCell.identifier)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.backgroundColor = .systemBackground
            return table
        }()
   
        var bookingDetails : BookingDetails?
        var childSurName: [String] = []
        var childFirstName: [String] = []
        var childLastName: [String] = []
        var adultSurName: [String] = []
        var adultFirstName: [String] = []
        var adultLastName: [String] = []
        var cancelleationJson : [Any] = []
        var activityBookInput : ActivityBookingInput?
        var imgUrl = String()
        var ratekey = String()
        var searchID = String()
        var dates = String()
        var totPrice = String()
        var adultPrice = String()
        var childPrice = String()
        var duration = String()
        var activityName = String()
        var childNo : Int?
        var adultNo : Int?
        var cancellation = [CancellationPolicy]()
        var CFn1,CFn2,CFn3,CFn4,CSn1,CSn2,CSn3,CSn4 ,CLn1, CLn2, CLn3, CLn4 : String?
        var AFn1,AFn2,AFn3,AFn4,ASn1,ASn2,ASn3,ASn4 ,ALn1, ALn2, ALn3, ALn4 : String?
        var hName,chekInD,pAdd,email,phNumber : String?
        var activityBookResponse :  BookingDetails?
        var activityDetailsResult = [ActivityDetailsResult]()
        override func viewDidLoad (){
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            self.parent?.title = "Hotels"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            tableView.reloadData()
            navigationItem.leftBarButtonItem?.tintColor = .systemGray
            view.backgroundColor = .systemBackground
            view.addSubview(tableView)
            tableView.frame = view.bounds
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
        }
        @objc private func didTapBackButton() {
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant:  -10)
            ])
        }
    }
    extension HotelConfirmPreviewViewController : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelConfirmPreviewHeadTableViewCell.identifier, for: indexPath) as? HotelConfirmPreviewHeadTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            if indexPath.section == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelConfirmedInfoTableViewCell.identifier, for: indexPath) as? HotelConfirmedInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.gotoHomeClicked = {
                    let vc  = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
                    vc?.modalPresentationStyle = .fullScreen
                    self.present(vc!, animated: true)
                }
                return cell
            }
            return UITableViewCell()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 110
            }
            if indexPath.section == 1 {
                return 500
            }
            return 0
        }

    }

