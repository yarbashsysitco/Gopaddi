//
//  FlightListViewController.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit
protocol FlightFilterInput {
    func filterDetails(prRange: String, value: Int, star: [Int])
}
protocol FlightsortInfo {
    func sortDetails(sortValue : Int)
}
class FlightListViewController: UIViewController,FlightFilterInput , FlightsortInfo,UITableViewDelegate,UITableViewDataSource{
    var hotelListResult : [HotelListResult]?
    var hotelLists : [HotelList]?
    
    let apiManager = ApiManager()
    var sortID : String?
    var filterDuration : [String]?
    var activityId = String()
    var location = String()
    var dated = String()
    var childCount = String()
    var adultCount = String()
    var childAges = [Int]()
    var userLogin = String()
    
    var fromTFField: String = ""
    var toTFField : String = ""
    var departonTFField: String = ""
    var returnonTFField : String = ""
    var cabinvalueTFField : String = ""
    var adultCountTFField : String = ""
    var childCountTFField: String = ""
    var infantsCountTFField : String = ""
    var tripTypeTFField : String = ""
    var Flightsearch: FlightsearchModel?
    var flightResult: FlightResult?
    var Onewaydat = [Onewaydatas]()
    
    
    
    var departonCodes: String = ""
    var returnonCodes: String = ""
    
    
    
    let topHeaderBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let topHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var placeDepartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 16)
        label.textColor = .label
        label.text = "BAK - TBS"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var placeReturnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 16)
        label.textColor = .label
        label.text = "TBS - BAK"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dateDepartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .label
        label.text = "13 July"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dateReturnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .label
        label.text = "17 July"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let sepView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let imigImageView: UIButton = {
        let button =  UIButton()
        button.backgroundColor = .systemGray3
        button.setImage(UIImage(systemName: "pencil")?.withTintColor(.label, renderingMode: .alwaysTemplate), for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let filterButton: UIButton  = {
        let button = UIButton()
        button.configuration = .plain()
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.backgroundColor = .tertiarySystemBackground
        button.configuration?.title = "Filter"
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.configuration?.image = UIImage(systemName: "slider.horizontal.3")
        button.configuration?.imagePadding = 10
        button.configuration?.baseForegroundColor = .label
        button.configuration?.imagePlacement = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let sortButton: UIButton  = {
        let button = UIButton()
        button.configuration = .plain()
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.backgroundColor = .tertiarySystemBackground
        button.configuration?.title = "Sort"
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.configuration?.baseForegroundColor = .label
        button.configuration?.image = UIImage(systemName: "list.bullet.indent")
        button.configuration?.imagePadding = 10
        button.configuration?.imagePlacement = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FlightListTableViewCell.self, forCellReuseIdentifier: FlightListTableViewCell.identifier)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        disableUserInteraction()
        apicall()
        view.backgroundColor = .secondarySystemBackground
        title = "Flight"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        imigImageView.cornerR = 12.5
        tableView.reloadData()
        view.addSubview(headerView)
        view.addSubview(topHeaderBackView)
        topHeaderBackView.addSubview(topHeaderView)
        topHeaderView.addSubview(placeDepartLabel)
        topHeaderView.addSubview(dateDepartLabel)
        topHeaderView.addSubview(placeReturnLabel)
        topHeaderView.addSubview(dateReturnLabel)
        topHeaderView.addSubview(imigImageView)
        topHeaderView.addSubview(sepView)
        headerView.addSubview(sortButton)
        headerView.addSubview(filterButton)
        view.addSubview(tableView)
        sortButton.addTarget(self, action: #selector(tappedSort), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(tappedFilter), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        hotelLists = hotelListResult?[0].hotelList
        updateDepartureCode()
    }
    func updateDepartureCode() {
        placeDepartLabel.text = departonCodes
        placeReturnLabel.text = returnonCodes
    }
    private func enableUserInteraction() {
        view.isUserInteractionEnabled = true
    }
    
    
    func apicall(){
        tableView.showLoading()
        let fromField = fromTFField
        let toField = toTFField
        let departonField = departonTFField
        let returnonField = returnonTFField
        let cabinField = cabinvalueTFField
        let adultCountField = adultCountTFField
        let childCountField = childCountTFField
        let infantsCountField = infantsCountTFField
        let tripTypeField = tripTypeTFField
        ApiManager.shared.flightapisearch(user: "260",
                                          tripType: tripTypeField,
                                          fromCity: fromField,
                                          toCity: toField,
                                          departDate: departonField,
                                          returnDate: returnonField,
                                          adultss: adultCountField,
                                          childss: adultCountField,
                                          infants: childCountField,
                                          cabinClass: cabinField) { [self] result in
            switch result{
            case.success(let model):
                DispatchQueue.main.async {[weak self] in
                    if model.code == "200" {
                        self?.Flightsearch = model
                        //                               self?.Onewaydat = model.result.
                        print(" Successfulllyokkkkkkk : \(model.result)")
                        self?.tableView.stopLoading()
                        self?.tableView.reloadData()
                        self?.enableUserInteractions()
                    }
                    else {
                        let alertcontrollert = UIAlertController(title: "Error" , message: "Something went wrong!", preferredStyle: .alert)
                        let alertButoon = UIAlertAction(title: "Ok", style: .default) { _ in
                            print("Error")
                        }
                        alertcontrollert.addAction(alertButoon)
                        self?.present(alertcontrollert, animated: true)
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func disableUserInteraction() {
        view.isUserInteractionEnabled = false
    }
       private func enableUserInteractions() {
        view.isUserInteractionEnabled = true
    }
    func filterDetails(prRange: String, value: Int, star: [Int]) {
        callFilterApi(priceRange: prRange, orderValue: value, starRate: star)
    }
    func callFilterApi(priceRange: String, orderValue: Int, starRate: [Int]){
        tableView.showLoading()
        let searchID = String((hotelListResult?[0].searchId)!)
        ApiManager.shared.hotelFilter(searchId: searchID, value: orderValue, price: priceRange, star: starRate){
            result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    self.hotelLists = model.result?[0].hotelList
                    self.tableView.reloadData()
                    self.tableView.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.tableView.showLoading()
            }
        }
    }
    func sortDetails(sortValue: Int) {
        switch sortValue {
        case 1:  hotelLists?.sort(by: {$0.productId < $1.productId})
        case 2:  hotelLists?.sort(by: {$0.totalPrice < $1.totalPrice})
        case 3:  hotelLists?.sort(by: {$0.totalPrice > $1.totalPrice})
        case 4:  hotelLists?.sort(by: {$0.hotelRating > $1.hotelRating})
        default:
            print("Invalid")
        }
        self.tableView.reloadData()
    }
    @objc  func tappedSort() {
        let vc = FlightSortViewController()
        let navVC = UINavigationController(rootViewController: vc)
        //                            vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(navVC, animated: true)
    }
    @objc  func tappedFilter() {
        let vc = FlightFlterViewController()
        let navVC = UINavigationController(rootViewController: vc)
        //            vc.maxPrice = CGFloat(hotelList[0].maxprice ?? 0)
        //            vc.minPrice = CGFloat(hotelList[0].minprice ?? 0)
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.dismiss(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            
            topHeaderBackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            topHeaderBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topHeaderBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topHeaderBackView.heightAnchor.constraint(equalToConstant: 100),
            
            
            topHeaderView.centerYAnchor.constraint(equalTo: topHeaderBackView.centerYAnchor),
            topHeaderView.leadingAnchor.constraint(equalTo: topHeaderBackView.leadingAnchor, constant: 20),
            topHeaderView.trailingAnchor.constraint(equalTo: topHeaderBackView.trailingAnchor, constant: -20),
            topHeaderView.heightAnchor.constraint(equalToConstant: 60),
            
            
            placeDepartLabel.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 8),
            placeDepartLabel.leadingAnchor.constraint(equalTo: topHeaderView    .leadingAnchor, constant: 20),
            placeDepartLabel.widthAnchor.constraint(equalToConstant: 100),
            
            dateDepartLabel.topAnchor.constraint(equalTo: placeDepartLabel.bottomAnchor, constant: 6),
            dateDepartLabel.leadingAnchor.constraint(equalTo: topHeaderView    .leadingAnchor, constant: 20),
            dateDepartLabel.widthAnchor.constraint(equalToConstant: 100),
            
            sepView.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 0),
            sepView.leadingAnchor.constraint(equalTo: placeDepartLabel    .trailingAnchor, constant: 16),
            sepView.bottomAnchor.constraint(equalTo: topHeaderView    .bottomAnchor),
            sepView.widthAnchor.constraint(equalToConstant: 1),
            
            placeReturnLabel.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 8),
            placeReturnLabel.leadingAnchor.constraint(equalTo: sepView    .trailingAnchor, constant: 20),
            placeReturnLabel.widthAnchor.constraint(equalToConstant: 100),
            
            dateReturnLabel.topAnchor.constraint(equalTo: placeReturnLabel.bottomAnchor, constant: 6),
            dateReturnLabel.leadingAnchor.constraint(equalTo: sepView    .trailingAnchor, constant: 20),
            dateReturnLabel.widthAnchor.constraint(equalToConstant: 100),
            
            imigImageView.centerYAnchor.constraint(equalTo: topHeaderView.centerYAnchor),
            imigImageView.trailingAnchor.constraint(equalTo: topHeaderView    .trailingAnchor, constant: -16),
            imigImageView.widthAnchor.constraint(equalToConstant: 25),
            imigImageView.heightAnchor.constraint(equalToConstant: 25),
            
            headerView.topAnchor.constraint(equalTo:topHeaderView.bottomAnchor, constant: 15),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            filterButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            filterButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            filterButton.widthAnchor.constraint(equalToConstant: 170),
            filterButton.heightAnchor.constraint(equalToConstant: 50),
            
            sortButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            sortButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            sortButton.widthAnchor.constraint(equalToConstant: 170),
            sortButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Flightsearch?.result[0].onewaydata.count) ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightListTableViewCell.identifier, for: indexPath) as? FlightListTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .tertiarySystemBackground
        //               cell.configure(hotelList: (hotelLists?[indexPath.row])!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FlightDetailsViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

