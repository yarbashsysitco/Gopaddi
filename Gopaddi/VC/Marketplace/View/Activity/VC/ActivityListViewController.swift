//
//  ActivityListViewController.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//


import UIKit
import Fastis
import SDWebImage

protocol sortInfo {
    func sortDetails(sortValue : String)
}
protocol FilterInfo{
    func filterDetails(prRange : String, duration: [String] )
}
class ActivityListViewController: UIViewController, sortInfo, FilterInfo {
    static let identifier = "ActivityListViewController"
    var activityListResponse : ActivityListResponse?
    var activityDetails : ActivityDetails?
    var activityDetailsResult : [ActivityDetailsResult]?
    var activityListResult : [ActivityListResult]?
    var activityList : [ActivityList]?
    let apiManager = ApiManager()
    var sortID : String?
    var priceRange : String?
    var filterDuration : [String]?
    var activityId = String()
    var userLogin = String()
    var dateAPI = String()
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private let filterButton: UIButton  = {
        let button = UIButton()
        button.configuration = .plain()
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.backgroundColor = .secondarySystemBackground
        button.configuration?.title = "Filter"
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 13)
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
        button.backgroundColor = .secondarySystemBackground
        button.configuration?.title = "Sort"
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 13)
        button.configuration?.baseForegroundColor = .label
        button.configuration?.image = UIImage(systemName: "list.bullet.indent")
        button.configuration?.imagePadding = 10
        button.configuration?.imagePlacement = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ActivityListTableViewCell.self, forCellReuseIdentifier: ActivityListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        title = "Activity"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
       
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(filterButton)
        headerView.addSubview(sortButton)
        view.addSubview(tableView)
        sortButton.addTarget(self, action: #selector(tappedSort), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(tappedFilter), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func filterDetails(prRange: String, duration: [String]) {
        priceRange = prRange
        filterDuration = duration
        callFilterApi()
    }
    
    func callFilterApi(){
        tableView.showLoading()
        let searchID = String(activityListResult?[0].searchId ?? 0)
        let location = activityListResult?[0].searchLocation ?? ""
        let countryID = activityListResult?[0].searchCountry ?? ""
        let cityID = activityListResult?[0].searchCity ?? ""
        ApiManager.shared.activityFilter(searchId: searchID, location: location, countryId: countryID, cityId: cityID, prices: priceRange ?? "", day: filterDuration ?? []){
            result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    self.activityListResponse = model
                    self.activityListResult = model.result
                    self.tableView.reloadData()
                    self.tableView.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.tableView.showLoading()
            }
        }
    }
    
    func sortDetails(sortValue: String) {
        sortID = sortValue
        callSortApi()
    }
    func callSortApi(){
        tableView.showLoading()
        let searchID = String(activityListResult?[0].searchId ?? 0)
        let location = activityListResult?[0].searchLocation ?? ""
        let countryID = activityListResult?[0].searchCountry ?? ""
        let cityID = activityListResult?[0].searchCity ?? ""
        ApiManager.shared.activitySort(searchId: searchID, location: location, countryId: countryID, cityId: cityID, value: sortID ?? "") { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.activityListResponse = model
                    self.activityListResult = model.result
                    self.tableView.reloadData()
                    self.tableView.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.tableView.showLoading()
            }
        }
    }
    @objc  func tappedSort() {
        let vc = ActivitySortViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    @objc  func tappedFilter() {
        let vc = ActivityFilterViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.delegate = self
        vc.maxPrice = CGFloat(activityListResult?[0].maxprice ?? 0)
        vc.minPrice = CGFloat(activityListResult?[0].minprice ?? 0)
        vc.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    @objc private func didTapBackButton() {
        self.dismiss(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            filterButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            filterButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            filterButton.widthAnchor.constraint(equalToConstant: 120    ),
            filterButton.heightAnchor.constraint(equalToConstant: 35),
            
            sortButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            sortButton.leadingAnchor.constraint(equalTo: filterButton.trailingAnchor, constant: 20),
            sortButton.widthAnchor.constraint(equalToConstant: 120),
            sortButton.heightAnchor.constraint(equalToConstant: 35),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
extension ActivityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityListResult?[0].activityList.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityListTableViewCell.identifier, for: indexPath) as? ActivityListTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(activityList:(activityListResult?[0].activityList[indexPath.row])!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        let vc = ActivityDetailsViewController()
        vc.date = dateLabel.text ?? " "
        vc.dateApi = dateAPI
        vc.currency = activityListResult?[0].currency ?? ""
        vc.searchId = String(activityListResult?[0].searchId ?? 0)
        vc.activityCode = activityListResult?[0].activityList[indexPath.row].activityCode ?? "0"
        vc.imageUrl = activityListResult?[0].activityList[indexPath.row].featureImage ?? " "
        vc.name = activityListResult?[0].activityList[indexPath.row].activityName ?? " "
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}

