//
//  ActivityDetailsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit
import SDWebImage
class ActivityDetailsViewController: UIViewController {
        var activityDetailsResult : [ActivityDetailsResult]?
        var activityId: String = String()
        var searchId = String()
        var activityCode = String()
        var imageUrl = String()
        var name = String()
        var date = String()
        var dateApi = String()
        var currency = String()
        var userId = UserDefaults.standard.string(forKey: "logkey") ?? ""
        var count : Int?
        let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let titleLabel2: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let titleLabel3: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.separatorStyle = .none
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(ActivityDetailsHeadTableViewCell.self, forCellReuseIdentifier: ActivityDetailsHeadTableViewCell.identifier)
            tableView.register(ActivityInfoTableViewCell.self, forCellReuseIdentifier: ActivityInfoTableViewCell.identifier)
            tableView.register(ActivityDepartureTableViewCell.self, forCellReuseIdentifier: ActivityDepartureTableViewCell.identifier)
            tableView.register(AcivityCancelTableViewCell.self, forCellReuseIdentifier: AcivityCancelTableViewCell.identifier)
            tableView.register(ActivityBookTableViewCell.self, forCellReuseIdentifier: ActivityBookTableViewCell.identifier)
            tableView.register(PackageDescTableViewCell.self, forCellReuseIdentifier: PackageDescTableViewCell.identifier)
            return tableView
        }()
        var isIncluded : Bool = false
        var isDepart : Bool = false
        var isPolicy : Bool = false
        var isPackage : Bool = false
        override func viewDidLoad() {
            super.viewDidLoad()
            callApi()
            view.backgroundColor = .systemBackground
            title = " Activity"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            navigationItem.leftBarButtonItem?.tintColor = .systemBlue
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
        }
      
        func callApi(){
            tableView.showLoading()
            ApiManager.shared.activityDetails(searchId: searchId, activityCode: activityCode){ result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.activityDetailsResult = model.result
                        self.tableView.reloadData()
                        self.tableView.stopLoading()
                    }
                case .failure(let error):
                    self.tableView.stopLoading()
                    print(error.localizedDescription)
                }
            }
        }
        @objc private func didTapBackButton(){
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
               
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    extension ActivityDetailsViewController : UITableViewDelegate , UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 6
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 1 || section == 2 || section == 3 || section == 4{
                let headerView = UIView(frame: CGRect(x: 20, y: 20, width: tableView.frame.width - 20, height: 35))
                headerView.tag = section
                
                switch section {
                case 1 : headerView.addSubview(descriptionLabel)
                    descriptionLabel.text = "Package Description"
                    
                case 2 : headerView.addSubview(titleLabel)
                    titleLabel.text = "What's Included"
               
                case 3 : headerView.addSubview(titleLabel2)
                    titleLabel2.text = "Departure & Return"
                    
                case 4 :headerView.addSubview(titleLabel3)
                    titleLabel3.text = "Cancellation Policy"
                default:
                    print("Invalid")
                }
                headerView.backgroundColor = UIColor.systemBackground
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped(_:)))
                headerView.addGestureRecognizer(tapGesture)
                headerView.tag = section
                return headerView
            }
            return UIView()
        }
        @objc func sectionHeaderTapped(_ sender: UITapGestureRecognizer) {
            let section = sender.view?.tag ?? 0
            if section == 1 {
                isPackage = isPackage == true ? false : true
            }
            if section == 2 {
                isIncluded = isIncluded == true ? false : true
            }
            if section == 3 {
                isDepart = isDepart == true ? false : true
            }
            if section == 4 {
                isPolicy = isPolicy == true ? false : true
            }
            
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section  {
            case 0 : return 1
            case 1 : if isPackage
                { return 1 }
                else {
                return 0
            }
            case 2 : if isIncluded
                { return (activityDetailsResult?[0].included.count) ?? 0 }
                else {
                return 0
            }
            case 3 : if isDepart
                { return 1 }
                else{
                return 0
            }
            case 4 : if isPolicy { return (activityDetailsResult?[0].cancellation.count) ?? 0 }
                else {
                    return 0
                }
            case 5 : return activityDetailsResult?[0].activityPriceArray.count ?? 0
            default : print("Invalid")
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityDetailsHeadTableViewCell.identifier, for: indexPath) as? ActivityDetailsHeadTableViewCell else {
                    return UITableViewCell()}
                cell.configure(image: imageUrl , name: name, imageList: activityDetailsResult?[0].multiImage ?? [], duration: activityDetailsResult?[0].activityPriceArray[indexPath.row].duration ?? "")
                return cell
            }
            if indexPath.section == 1{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageDescTableViewCell.identifier, for: indexPath) as? PackageDescTableViewCell else {
                    return UITableViewCell()}
                cell.configure(content: (activityDetailsResult?[0].discription) ?? "")
                return cell
            }
            if indexPath.section == 2{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityInfoTableViewCell.identifier, for: indexPath) as? ActivityInfoTableViewCell else {
                    return UITableViewCell()}
                cell.configure(content: (activityDetailsResult?[0].included[indexPath.row].description) ?? "")
                return cell
            }
            
            if indexPath.section == 3{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityDepartureTableViewCell.identifier, for: indexPath) as? ActivityDepartureTableViewCell else {
                    return UITableViewCell()}
                cell.configure(content: activityDetailsResult?[0].DepartureAndReturn ?? "")
                return cell
            }
            if indexPath.section == 4{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AcivityCancelTableViewCell.identifier, for: indexPath) as? AcivityCancelTableViewCell else {
                    return UITableViewCell()}
                cell.configure(content: activityDetailsResult?[0].cancellation[indexPath.row].policy ?? "" , option: activityDetailsResult?[0].cancellation[indexPath.row].option ?? "")
                return cell
            }
            if indexPath.section == 5{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityBookTableViewCell.identifier, for: indexPath) as? ActivityBookTableViewCell else {
                    return UITableViewCell()}
                cell.configureText(activityDetails: (activityDetailsResult?[0].activityPriceArray[indexPath.row])!, cur: currency)
                cell.bookClicked = {
                        let vc = ActivityConfirmViewController()
                    vc.activityDetailsResult = self.activityDetailsResult ?? []
                        vc.imgUrl = self.activityDetailsResult?[0].featuredImage ?? ""
                        vc.ratekey = self.activityDetailsResult?[0].activityPriceArray[indexPath.row].rateKey ?? " "
                        vc.cancellation = (self.activityDetailsResult?[0].activityPriceArray[indexPath.row].cancellationPolicy) ?? []
                        vc.activityName =  self.activityDetailsResult?[0].ActivityName ?? " "
                        vc.duration = self.activityDetailsResult?[0].activityPriceArray[indexPath.row].duration ?? ""
                    vc.dates = self.date
                    vc.currency = self.currency
                    vc.searchID = self.searchId
                        vc.fromD = self.activityDetailsResult?[0].activityPriceArray[indexPath.row].fromDate ?? ""
                        vc.toD = self.activityDetailsResult?[0].activityPriceArray[indexPath.row].toDate ?? ""
                        vc.totPrice = String(self.activityDetailsResult?[0].activityPriceArray[indexPath.row].totalPrice ?? 0)
                        vc.adultPrice = String(self.activityDetailsResult?[0].activityPriceArray[indexPath.row].adultPrice ?? 0)
                        vc.childPrice = String(self.activityDetailsResult?[0].activityPriceArray[indexPath.row].childPrice ?? 0)
                        vc.childNo = Int(self.activityDetailsResult?[0].childNo ?? "1")
                        vc.adultNo = Int(self.activityDetailsResult?[0].adultNo ?? "0")
                        let navVC = UINavigationController(rootViewController: vc)
                        navVC.modalPresentationStyle = .fullScreen
                        self.present(navVC, animated: true)
                   
                }
                return cell
            }
            return UITableViewCell()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PackageDescTableViewCell.identifier) as! PackageDescTableViewCell
                cell.configure(content: (activityDetailsResult?[0].discription) ?? "")
                cell.layoutIfNeeded()
                let fittingSize = CGSize(width: tableView.frame.width, height: UIView.layoutFittingCompressedSize.height)
                let size = cell.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
                return size.height
                
            }
            if indexPath.section == 0 {
                return 380
            }
            if indexPath.section == 2 {
                return 30
            }
            if indexPath.section == 3 {
                return 25
            }
            if indexPath.section == 4 {
                return 80
            }
            if indexPath.section == 5 {
                return 170
            }
            return 0
        }

    }

