//
//  HotelListViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//
import UIKit
import Fastis
import SDWebImage
protocol HotelFilterInput {
    func inputData(prRange: String, value: Int, star: [Int])
}
protocol HotelsortInfo {
    func sortDetails(sortValue : Int)
}
class HotelListViewController: UIViewController, HotelFilterInput,HotelsortInfo {
    static let identifier = "HotelListViewController"
    
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
        button.backgroundColor = .tertiarySystemBackground
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
        button.backgroundColor = .tertiarySystemBackground
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
            tableView.register(HotelListTableViewCell.self, forCellReuseIdentifier: HotelListTableViewCell.identifier)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //            let attributedString = NSAttributedString(string: "Hotel", attributes: [
        //                       NSAttributedString.Key.foregroundColor: UIColor.red,
        //                       NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 16)!
        //                   ])
        //                   navigationItem.title = attributedString.string
        title = "Hotel"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
        tableView.reloadData()
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
        hotelLists = hotelListResult?[0].hotelList
    }
    func inputData(prRange: String, value: Int, star: [Int]) {
        callFilterApi(priceRange: prRange, orderValue: value, starRate: star)
    }
    func callFilterApi(priceRange: String, orderValue: Int, starRate: [Int]){
        tableView.showLoading()
        let searchID = String(hotelListResult?[0].searchId ?? 0)
        ApiManager.shared.hotelFilter(searchId: searchID, value: orderValue, price: priceRange, star: starRate){
            result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    self.hotelListResult = model.result
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
                    let vc = HotelSortViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    vc.modalPresentationStyle = .fullScreen
                    vc.delegate = self
                    self.present(navVC, animated: true)
    }
    @objc  func tappedFilter() {
        let vc = HotelFilterViewController()
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
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20 ),
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
extension HotelListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelLists?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelListTableViewCell.identifier, for: indexPath) as? HotelListTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .secondarySystemBackground
        cell.configure(hotelList: (hotelLists?[indexPath.row])!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchId = String(hotelListResult?[0].searchId ?? 0)
        let sessionId = hotelLists?[indexPath.row].sessionId ?? ""
        let rooms = String(hotelLists?[indexPath.row].rooms ?? 0)
        let night = hotelLists?[indexPath.row].nights ?? ""
        let productID = hotelLists?[indexPath.row].productId ?? ""
        let hotelID = hotelLists?[indexPath.row].hotelId ?? ""
        view.showLoading()
        let userId = UserDefaults.standard.string(forKey: "logkey") ?? ""
        ApiManager.shared.hotelDetails(searchId: searchId, sessionId: sessionId, rooms: rooms, nights: night, tokenId: userId, productId: productID, hotelId: hotelID){ result in
            switch result {
            case .success(let model):
                if model.code == "200"{
                    DispatchQueue.main.async {
                        let vc = HotelDetailsViewController()
                        vc.searchId = searchId
                        vc.date = self.dateLabel.text ?? " "
                        vc.imageUrl = self.hotelLists?[indexPath.row].image ?? ""
                        vc.name = self.hotelLists?[indexPath.row].hotelName ?? ""
                        vc.hotelDetailsResult = model.result
                        let nav = UINavigationController(rootViewController: vc)
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true)
                        self.view.stopLoading()
                    }}else {
                        let alert = UIAlertController(title: "Sorry1", message: "No Results Found", preferredStyle: .alert)
                        let alertBtn = UIAlertAction(title: "Ok", style: .cancel) {_ in
                            alert.dismiss(animated: true)
                        }
                        alert.addAction(alertBtn)
                        self.present(alert, animated: true)
                    }
            case .failure(let error):
                self.view.stopLoading()
                print(error.localizedDescription)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}

