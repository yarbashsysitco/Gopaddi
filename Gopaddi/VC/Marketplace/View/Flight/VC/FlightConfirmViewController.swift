//
//  FlightConfirmViewController.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//
import UIKit
import SDWebImage
class FlightConfirmViewController: UIViewController {

                let flight = ["Base Fare" , "Taxes and Fees (All Passengers)" ,"Vat","Service Charge","Discount","Total"]
            let flightValue = ["AED710.00" , "AED0" ,"AED0","AED0","AED0","AED710.00"]
            let fareRules = ["Onbound Flight", "Departure", "Vat","Service Charge","Discount","Total"]
            let fareRulesVlues = ["Flydubai" , "Dubai - Dubai (DXB)" ,"AED0","AED0","AED0","AED710.00"]
                let headerView: UIView = {
                    let view = UIView()
                    view.backgroundColor = UIColor(red: 0.156, green: 0.482, blue: 0.878, alpha: 1)
                    view.translatesAutoresizingMaskIntoConstraints = false
                    return view
                }()
        let HeadInfoLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.numberOfLines = 3
            label.text = "Please check your travel summary before the payment"
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
         
                let tableView: UITableView = {
                    let tableView = UITableView()
                    
                    tableView.register(FlightConfirmTableViewCell.self, forCellReuseIdentifier: FlightConfirmTableViewCell.identifier)
                    
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
         
        private let payButton: UIButton = {
            let button =  UIButton()
            button.layer.borderWidth = 0.1
            button.layer.cornerRadius = 10
            button.setTitle("Proceed to Pay", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor(red: 0.156, green: 0.482, blue: 0.878, alpha: 1)
            button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
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
                    payButton.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
                    view.addSubview(headerView)
                    headerView.addSubview(HeadInfoLabel)
                    view.addSubview(tableView)
                    view.addSubview(payAmtView)
                    payAmtView.addSubview(payButton)
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                }
        @objc private func didTapPayButton() {
           let vc = FlightPassengerEntryViewController()
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
                        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:0),
                        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                        headerView.heightAnchor.constraint(equalToConstant: 100),
                        
                        HeadInfoLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                        HeadInfoLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                        HeadInfoLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 20),
                        
                        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 20),
                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                        tableView.bottomAnchor.constraint(equalTo: payAmtView.topAnchor,constant: -5),
                        
                        payAmtView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                        payAmtView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        payAmtView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        payAmtView.heightAnchor.constraint(equalToConstant: 100),
                    
                        payButton.centerYAnchor.constraint(equalTo: payAmtView.centerYAnchor),
                        payButton.heightAnchor.constraint(equalToConstant: 48),
                        payButton.leadingAnchor.constraint(equalTo: payAmtView.leadingAnchor,constant: 20),
                        payButton.trailingAnchor.constraint(equalTo: payAmtView.trailingAnchor,constant: -20),
                    ])
                }
            }
            extension FlightConfirmViewController: UITableViewDelegate, UITableViewDataSource {
            
                func numberOfSections(in tableView: UITableView) -> Int {
                    return 2
                }
                func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                    switch section {
                    case 0:
                        return "Flight Value"
                    case 1:
                        return "Flight Details"
             
                    default:
                        print("Invalid")
                    
                    }
                    return nil
                }
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                    return 6
                }
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    if indexPath.section == 0{
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightConfirmTableViewCell.identifier, for: indexPath) as? FlightConfirmTableViewCell else {
                            return UITableViewCell()
                        }
                        cell.configure(firstname: flight[indexPath.row], secondname: flightValue[indexPath.row],indexpath: indexPath.row)
                        return cell
                    }
                    if indexPath.section == 1{
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightConfirmTableViewCell.identifier, for: indexPath) as? FlightConfirmTableViewCell else {
                            return UITableViewCell()
                        }
                        
                        cell.configure(firstname: fareRules[indexPath.row], secondname: fareRulesVlues[indexPath.row], indexpath: indexPath.row)
                        return cell
                    }
                  
                    return UITableViewCell()
                }
                    

                func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    if indexPath.section == 0{
                        return 70
                    }
                    if indexPath.section == 1{
                        return 70
                    }
                    return 0
                }
            }

