////
////  FlightViewController.swift
////  Gopaddi
////
////  Created by jizan k on 29/05/23.
////
//
//import UIKit
////protocol PassengerInfo{
////    func passengerCount(adultC : String, childC : String ,childrenAgesList : [Int])
////}
//
//class FlightViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, PassengerInfo{
//    func passengerCount(adultC: String, childC: String, infantsc: String) {
//        <#code#>
//    }
//    
////    func passengerCount(adultC: String, childC: String, infantsc: String) {
////        <#code#>
////    }
//    
//   
//    
////    var model = [Airport]()
//    var FlightairporsModel : FlightairportsModel?
//    var airportsModel : [Airport]?
//
//    var datePicker = UIDatePicker()
//    var datePicker2 = UIDatePicker()
//    let genders = ["Select","Male","Female"]
//    private let imigImageView: UIImageView = {
//        let imageview = UIImageView()
//        imageview.translatesAutoresizingMaskIntoConstraints = false
//        imageview.contentMode = .scaleAspectFill
//        imageview.backgroundColor = .systemBlue
//        return imageview
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Find Flight and Hotel Deals for Any Season"
//        label.numberOfLines = 2
//        label.font = UIFont(name: "Poppins-Medium", size: 20)
//        label.textColor = .white
//        return label
//    }()
//    private let aboutLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Search over 450 airlines and more than 320,00 hotels around the world."
//        label.numberOfLines = 0
//        label.font = UIFont(name: "Poppins-Regular", size: 14)
//        label.textColor = .white
//        return label
//    }()
//    private let contentView : UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .secondarySystemBackground
//        view.layer.cornerRadius = 30
//        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        return view
//    }()
//    private let buttonView : UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemGray4
//        view.layer.cornerRadius = 10
//        return view
//    }()
//    private let roundTripButton: UIButton = {
//        let button =  UIButton()
//        button.setTitle("Roundtrip", for: .normal)
//        button.setTitleColor(UIColor.label, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
//        button.isUserInteractionEnabled = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    private let oneWayButton: UIButton = {
//        let button =  UIButton()
//        button.setTitle("One-Way", for: .normal)
//        button.setTitleColor(UIColor.label, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
//        button.isUserInteractionEnabled = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    private let multiCityButton: UIButton = {
//        let button =  UIButton()
//        button.setTitle("Multicity", for: .normal)
//        button.setTitleColor(UIColor.label, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
//        button.isUserInteractionEnabled = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    private let fromTF: UITextField = {
//        let field =  UITextField()
//        field.layer.borderWidth = 1
//        field.autocorrectionType = .yes
//        field.autocapitalizationType = .none
//        field.layer.cornerRadius = 10
//        field.textColor = .label
//        field.font = UIFont(name: "Poppins-Regular", size: 14)
//        field.layer.borderWidth = 1.0
//        field.layer.borderColor = UIColor.systemGray.cgColor
//        field.backgroundColor = .secondarySystemBackground
//        field.setupLeftView(imageViewNamed:"flightUp")
//        field.placeholder = "Leaving from"
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
//    private let toTF: UITextField = {
//        let field =  UITextField()
//        field.layer.borderWidth = 1
//        field.autocorrectionType = .yes
//        field.autocapitalizationType = .none
//        field.layer.cornerRadius = 10
//        field.textColor = .label
//        field.font = UIFont(name: "Poppins-Regular", size: 14)
//        field.layer.borderWidth = 1.0
//        field.layer.borderColor = UIColor.systemGray.cgColor
//        field.backgroundColor = .secondarySystemBackground
//        field.setupLeftView(imageViewNamed:"flightDown")
//        field.placeholder = "Going to"
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
//    
//    private let tableViewOption: UITableView = {
//        let tableView = UITableView()
//        tableView.separatorStyle = .none
//        tableView.tag = 1
//        return tableView
//    }()
//    private let departOnTf: UITextField = {
//        let field =  UITextField()
//        field.layer.borderWidth = 1
//        field.autocorrectionType = .yes
//        field.autocapitalizationType = .none
//        field.layer.cornerRadius = 10
//        field.placeholder = "Depart on"
//        field.textColor = .label
//        field.font = UIFont(name: "Poppins-Regular", size: 14)
//        field.layer.borderWidth = 1.0
//        field.layer.borderColor = UIColor.systemGray.cgColor
//        field.backgroundColor = .secondarySystemBackground
//        field.setupLeftViewN(imageViewNamed: "calendar")
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
//    private let returnOnTf: UITextField = {
//        let field =  UITextField()
//        field.layer.borderWidth = 1
//        field.autocorrectionType = .yes
//        field.autocapitalizationType = .none
//        field.layer.cornerRadius = 10
//        field.placeholder = "Return on"
//        field.textColor = .label
//        field.font = UIFont(name: "Poppins-Regular", size: 14)
//        field.layer.borderWidth = 1.0
//        field.layer.borderColor = UIColor.systemGray.cgColor
//        field.backgroundColor = .secondarySystemBackground
//        field.setupLeftViewN(imageViewNamed: "calendar")
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
//    private let passengerCount: UITextField = {
//        let field =  UITextField()
//        field.layer.borderWidth = 1
//        field.autocorrectionType = .yes
//        field.autocapitalizationType = .none
//        field.layer.cornerRadius = 10
//        field.placeholder = "Passenger"
//        field.textColor = .label
//        field.font = UIFont(name: "Poppins-Regular", size: 14)
//        field.layer.borderWidth = 1.0
//        field.layer.borderColor = UIColor.systemGray.cgColor
//        field.backgroundColor = .secondarySystemBackground
//        field.setupLeftViewN(imageViewNamed: "figure.2.and.child.holdinghands")
//        field.isUserInteractionEnabled = true // Make it non-editable
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
//    private let searchButton: UIButton = {
//        let button =  UIButton()
//        button.layer.borderWidth = 0.1
//        button.layer.cornerRadius = 10
//        button.setTitle("Search flights", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
//        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
//        button.isUserInteractionEnabled = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    var childrenAges : [Int]?
//    var adultCount : String?
//    var childCount : String?
//    var dateString = String()
//    var activityListResponse : ActivityListResponse?
//    var activityListResult : ActivityListResult?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        
//        title = "Flight"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
//        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
//        view.addSubview(imigImageView)
//        view.addSubview(titleLabel)
//        view.addSubview(aboutLabel)
//        view.addSubview(contentView)
//        contentView.addSubview(buttonView)
//        buttonView.addSubview(roundTripButton)
//        buttonView.addSubview(oneWayButton)
//        buttonView.addSubview(multiCityButton)
//        contentView.addSubview(fromTF)
//        contentView.addSubview(toTF)
//        contentView.addSubview(departOnTf)
//        contentView.addSubview(returnOnTf)
//        contentView.addSubview(passengerCount)
//        contentView.addSubview(searchButton)
//        contentView.addSubview(tableViewOption)
//        passengerCount.delegate = self
//        searchButton.addTarget(self, action: #selector(tappedSearch), for: .touchUpInside)
//        configurePicker()
//        configurePicker2()
//        returnOnTf.isHidden = true
//        roundTripButton.addTarget(self, action: #selector(roundTripButtonTapped), for: .touchUpInside)
//        oneWayButton.addTarget(self, action: #selector(oneWayButtonTapped), for: .touchUpInside)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        view.addGestureRecognizer(tapGesture)
////
//    }
//    
//    @objc func handleTap() {
//        view.endEditing(true) // This will dismiss the keyboard
//    }
//    
//    private let tableViewOption2: UITableView = {
//        let tableView = UITableView()
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = .tertiarySystemBackground
//        tableView.tag = 1
//        return tableView
//    }()
//    
//    
//    @objc private func roundTripButtonTapped() {
//        returnOnTf.isHidden = false
//
//        }
//        
//    @objc private func oneWayButtonTapped() {
//        returnOnTf.isHidden = true
//        }
//        
//    private func configurePicker(){
//        let toolBar = UIToolbar()
//        let toolBar2 = UIToolbar()
//        toolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
//        toolBar.setItems([doneButton], animated: true)
//        departOnTf.inputAccessoryView = toolBar
//        datePicker.preferredDatePickerStyle = .inline
//        datePicker.datePickerMode = .date
//        departOnTf.inputView = datePicker
//    }
//   private func configurePicker2(){
//        let toolBar = UIToolbar()
//        let toolBar2 = UIToolbar()
//        toolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed2))
//        toolBar.setItems([doneButton], animated: true)
//        returnOnTf.inputAccessoryView = toolBar
//       datePicker2.preferredDatePickerStyle = .inline
//       datePicker2.datePickerMode = .date
//        returnOnTf.inputView = datePicker2
//    }
//
//    @objc private func donePressed() {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        let selectedDate = datePicker.date
//        departOnTf.text = formatter.string(from: selectedDate)
//        self.view.endEditing(true) // Use true to dismiss the keyboard
//    }
//
//    @objc private func donePressed2() {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        let selectedDate = datePicker2.date
//        returnOnTf.text = formatter.string(from: selectedDate)
//        self.view.endEditing(true) // Use true to dismiss the keyboard
//    }
//
//    func passengerCount(adultC: String, childC: String, childrenAgesList: [Int]) {
//        adultCount = adultC
//        childCount = childC
//        passengerCount.text = adultC + " Adults & " + childC + " Children"
//        self.passengerCount.resignFirstResponder()
//        childrenAges = childrenAgesList
//    }
//    
//    @objc func tappedSearch() {
//        let vc = FlightListViewController()
//        
//        let navVC =  UINavigationController(rootViewController: vc)
//        navVC.modalPresentationStyle = .fullScreen
//        self.present(navVC, animated: true)
//        
//    }
//    
//    @objc private func didTapBackButton() {
//        navigationController?.dismiss(animated: true)
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        NSLayoutConstraint.activate([
//            imigImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
//            imigImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            imigImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            imigImageView.heightAnchor.constraint(equalToConstant: 240),
//            
//            titleLabel.topAnchor.constraint(equalTo: imigImageView.topAnchor, constant: 48),
//            titleLabel.leadingAnchor.constraint(equalTo: imigImageView.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: imigImageView.trailingAnchor, constant: -20),
//            
//            aboutLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
//            aboutLabel.leadingAnchor.constraint(equalTo: imigImageView.leadingAnchor, constant: 25),
//            aboutLabel.trailingAnchor.constraint(equalTo: imigImageView.trailingAnchor, constant: -80),
//            
//            contentView.topAnchor.constraint(equalTo: imigImageView.bottomAnchor, constant: -30),
//            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            buttonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
//            buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
//            buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
//            buttonView.heightAnchor.constraint(equalToConstant: 40),
//            
//            roundTripButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
//            roundTripButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
//            roundTripButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
//            roundTripButton.widthAnchor.constraint(equalToConstant: 100),
//            
//            oneWayButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
//            oneWayButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
//            oneWayButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
//            oneWayButton.widthAnchor.constraint(equalToConstant: 90),
//            
//            multiCityButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
//            multiCityButton.trailingAnchor.constraint(equalTo: buttonView   .trailingAnchor),
//            multiCityButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
//            multiCityButton.widthAnchor.constraint(equalToConstant: 100),
//            
//            fromTF.topAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 30),
//            fromTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            fromTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            fromTF.heightAnchor.constraint(equalToConstant: 48),
//            
//            toTF.topAnchor.constraint(equalTo: fromTF.bottomAnchor, constant: 20),
//            toTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            toTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            toTF.heightAnchor.constraint(equalToConstant: 48),
//            
//            departOnTf.topAnchor.constraint(equalTo: toTF.bottomAnchor, constant: 20),
//            departOnTf.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            departOnTf.widthAnchor.constraint(equalToConstant: 160),
//            departOnTf.heightAnchor.constraint(equalToConstant: 48),
//            
//            returnOnTf.topAnchor.constraint(equalTo: toTF.bottomAnchor, constant: 20),
//            returnOnTf.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            returnOnTf.widthAnchor.constraint(equalToConstant: 160),
//            returnOnTf.heightAnchor.constraint(equalToConstant: 48),
//            
//            passengerCount.topAnchor.constraint(equalTo: departOnTf .bottomAnchor, constant: 20),
//            passengerCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            passengerCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            passengerCount.heightAnchor.constraint(equalToConstant: 48),
//            
//            searchButton.topAnchor.constraint(equalTo: passengerCount.bottomAnchor, constant: 30),
//            searchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            searchButton.heightAnchor.constraint(equalToConstant: 48),
//        ])
//    }
//}
//extension FlightViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        fromTF.resignFirstResponder()
//    }
//    internal func textFieldDidChangeSelection(_ textField: UITextField)  {
//        if textField == fromTF{
//            if textField.text == "Destination" {
//                textField.text = " "
//            }
//            self.tableViewOption.showLoading()
////            if let text = textField.text {
//                ApiManager.shared.flightairports(user: "260", keyword: text){ result in
//                    switch result {
//                    case.success(let model):
//                        DispatchQueue.main.async {
//                            self.FlightairporsModel = model
//                            self.airportsModel = model.airports
//                            self.tableViewOption.reloadData()
//                            self.setupTableViewOption(tablevieww: self.tableViewOption)
//                            self.tableViewOption.delegate = self
//                            self.tableViewOption.dataSource  = self
//                            self.animateOptionTableView(tableVieww: self.tableViewOption, tag: 1, load: true)
//                            self.tableViewOption.stopLoading()
//                        }
//                    case.failure(let error):
//                        print(error.localizedDescription)
//                        
//                    }
//                }
//            }
//        }
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//       if textField == passengerCount {
//            self.passengerCount.resignFirstResponder()
//           let aStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = aStoryboard.instantiateViewController(withIdentifier: "PassengerViewController") as! PassengerViewController
//            vc.delegate = self
//            present(vc, animated: true)
//        }
//    }
//    func setupTableViewOption(tablevieww: UITableView) {
//        tablevieww.frame = CGRect(x: 20, y: view.frame.height, width: view.frame.width - 40, height: view.frame.height / 1.4)
//        tablevieww.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tablevieww.layer.shadowOffset = CGSize(width: 0.8, height: 0.6)
//        tablevieww.layer.shadowRadius = 2
//        tablevieww.layer.shadowOpacity = 2
//        tablevieww.layer.cornerRadius = 10
//    }
//    func animateOptionTableView(tableVieww: UITableView, tag: Int ,load: Bool) {
//        if load {
//            UIView.animate(withDuration: 0.2 ){
//                tableVieww.frame = CGRect(x: 4, y: self.view.frame.height / 1.94, width: self.view.frame.width - 10, height: 440)
//            }
//            tableVieww.isHidden = false
//            tableVieww.layer.borderWidth = 0.2
//        }
//        else {
//            UIView.animate(withDuration: 0.2, animations: {
//                tableVieww.frame = CGRect(x: 20, y: self.view.frame.height, width: self.view.frame.width - 40, height: self.view.frame.height - 170)
//            }) { done in
//                for subView in self.view.subviews {
//                    if  subView.tag == tag {
//                        subView.isHidden = true
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return airportsModel?.count ?? 00
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = airportsModel?[indexPath.row].label
//
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        self.fromTF.text = airportsModel?[indexPath.row].label
//        view.endEditing(false)
//        self.tableViewOption.resignFirstResponder()
//        self.fromTF.resignFirstResponder()
//        self.view.backgroundColor = .systemBackground
//        animateOptionTableView(tableVieww: tableViewOption, tag: 1, load: false)
//
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//    
//}
