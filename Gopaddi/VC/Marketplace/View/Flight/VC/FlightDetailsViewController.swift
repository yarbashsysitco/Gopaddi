//
//  FlightDetailsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit
import SDWebImage
class FlightDetailsViewController: UIViewController {

            let baggage = ["DXB -> COK" , "Cabin" ,"Check-in"]
        let baggageValue = ["ATD" , "5 - 7kg" ,"Weight: 30kg"]
        let fareRules = ["Airline", "Aircraft Type", "No Rules. No comments given by airline."]
        let fareRulesVlues = ["FZ - 441 - Flydubai" , "73H" ,""]
            let headerView: UIView = {
                let view = UIView()
                view.backgroundColor = .secondarySystemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
        private let baggageTF: UITextField = {
            let field =  UITextField()
            field.layer.borderWidth = 1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.font = UIFont(name: "Poppins-Regular", size: 14)
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray.cgColor
            field.backgroundColor = .secondarySystemBackground
            field.setupLeftView(imageViewNamed:"baggage")
            field.placeholder = "Baggage"
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
            var titleLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont(name: "Poppins-SemiBold", size: 16)
                label.textColor = .label
                label.text = "Baku - Tbilisi"
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
        var subTitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.textColor = .label
            label.text = "Travel time: 1h 10m"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
            let tableView: UITableView = {
                let tableView = UITableView()
                tableView.register(FlightListTableViewCell.self, forCellReuseIdentifier: FlightListTableViewCell.identifier)
                tableView.register(FlightItineraryTableViewCell.self, forCellReuseIdentifier: FlightItineraryTableViewCell.identifier)
                tableView.register(FlightFareBreakTableViewCell.self, forCellReuseIdentifier: FlightFareBreakTableViewCell.identifier)
                tableView.register(FlightDetAmountTableViewCell.self, forCellReuseIdentifier: FlightDetAmountTableViewCell.identifier)
                
                tableView.backgroundColor = .secondarySystemBackground
                tableView.translatesAutoresizingMaskIntoConstraints = false
                return tableView
            }()
        let payAmtView: UIView = {
            let view = UIView()
            view.backgroundColor = .tertiarySystemBackground
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let totalLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "900 NGN"
            label.font = UIFont(name: "Poppins-Medium", size: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    let dotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.text = "."
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Medium", size: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        let timeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "1h 10min"
            label.numberOfLines = 0
            label.font = UIFont(name: "Poppins-Medium", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    private let buyButton: UIButton = {
        let button =  UIButton()
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 10
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
     
            override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = .secondarySystemBackground
                title = "Flight"
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
                navigationItem.leftBarButtonItem?.tintColor = .systemBlue
                tableView.reloadData()
                view.addSubview(headerView)
                view.addSubview(baggageTF)
                view.addSubview(titleLabel)
                view.addSubview(subTitleLabel)
                view.addSubview(tableView)
                view.addSubview(payAmtView)
                payAmtView.addSubview(totalLabel)
                payAmtView.addSubview(timeLabel)
                payAmtView.addSubview(dotLabel)
                payAmtView.addSubview(buyButton)
                tableView.delegate = self
                tableView.dataSource = self
                tableView.reloadData()
                buyButton.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
            }
          
        @objc private func didTapPayButton() {
            let vc = FlightConfirmViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
            @objc private func didTapBackButton() {
                navigationController?.dismiss(animated: true)
            }
            override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                NSLayoutConstraint.activate([
                    baggageTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                    baggageTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
                    baggageTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    baggageTF.heightAnchor.constraint(equalToConstant: 48),
                    
                    titleLabel.topAnchor.constraint(equalTo: baggageTF.bottomAnchor, constant: 30),
                    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    
                    subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                    subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    
                    tableView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor,constant: 20),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                    tableView.bottomAnchor.constraint(equalTo: payAmtView.topAnchor,constant: -5),
                  
                    payAmtView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
                    payAmtView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                    payAmtView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                    payAmtView.heightAnchor.constraint(equalToConstant: 80),
                    
                    totalLabel.centerYAnchor.constraint(equalTo: payAmtView.centerYAnchor),
                    totalLabel.leadingAnchor.constraint(equalTo: payAmtView.leadingAnchor, constant: 20),
                    
                    dotLabel.topAnchor.constraint(equalTo: payAmtView.topAnchor,constant: 25),
                    dotLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 5),
                    
                    timeLabel.centerYAnchor.constraint(equalTo: payAmtView.centerYAnchor),
                    timeLabel.leadingAnchor.constraint(equalTo: dotLabel.trailingAnchor,constant: 5),

                    buyButton.centerYAnchor.constraint(equalTo: payAmtView.centerYAnchor),
                    buyButton.heightAnchor.constraint(equalToConstant: 48),
                    buyButton.widthAnchor.constraint(equalToConstant: 150),
                    buyButton.trailingAnchor.constraint(equalTo: payAmtView.trailingAnchor, constant: -20),
                ])
            }
        }
        extension FlightDetailsViewController: UITableViewDelegate, UITableViewDataSource {
        
            func numberOfSections(in tableView: UITableView) -> Int {
                return 5
            }
            func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                switch section {
                case 1:
                    return "Flight Itinerary"
                case 2:
                    return "Fare Breakup"
                case 3:
                    return "Fare Rules"
                case 4:
                    return "Baggage Information"
                default:
                    print("Invalid")
                
                }
                return nil
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                switch section {
                case 1:
                    return 1
                case 2:
                    return 1
                case 3:
                    return 3
                case 4:
                    return 3
                default:
                    print("Invalid")
                
                }
                return 1
            }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                if indexPath.section == 0{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightListTableViewCell.identifier, for: indexPath) as? FlightListTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.backgroundColor = .secondarySystemBackground
                    //            cell.configure(hotelList: (hotelLists?[indexPath.row])!)
                    return cell
                }
                if indexPath.section == 1{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightItineraryTableViewCell.identifier, for: indexPath) as? FlightItineraryTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.backgroundColor = .secondarySystemBackground
                    //            cell.configure(hotelList: (hotelLists?[indexPath.row])!)
                    return cell
                }
                if indexPath.section == 2{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightFareBreakTableViewCell.identifier, for: indexPath) as? FlightFareBreakTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.backgroundColor = .secondarySystemBackground
                    cell.configure(firstname: "Total Price", secondname: "AED 710,00")
                    return cell
                }
                if indexPath.section == 3{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightFareBreakTableViewCell.identifier, for: indexPath) as? FlightFareBreakTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.backgroundColor = .secondarySystemBackground
                    cell.configure(firstname: fareRules[indexPath.row], secondname: fareRulesVlues[indexPath.row])
                    return cell
                }
                if indexPath.section == 4{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightFareBreakTableViewCell.identifier, for: indexPath) as? FlightFareBreakTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.backgroundColor = .secondarySystemBackground
                    cell.configure(firstname: baggage[indexPath.row], secondname: baggageValue[indexPath.row])
                    return cell
                }
                return UITableViewCell()
            }
                

            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if indexPath.section == 0{
                    return 250
                }
                if indexPath.section == 1{
                    return 200
                }
                if indexPath.section == 2{
                    return 70
                }
                if indexPath.section == 3{
                    return 60
                }
                return 60
            }
        }

