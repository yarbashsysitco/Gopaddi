//
//  CountryViewController.swift
//  Gopaddi
//
//  Created by jizan k on 06/02/23.
//

import UIKit
class CountryViewController: UIViewController {
    var tag = Int()
    var country : CountryData?
    var completionHandler: ((CountryData) -> CountryData)?
    var nationalCountryKey: String?
    let apiManager = ApiManager()
    var countries = [CountryResult]()
    var searchedCountries = [CountryResult]()
    var registration: Register?
    let utilFunc = UtilitiesFunctions()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.indicatorStyle = .white
        return scrollView
    }()
    // contenView
    private let contenView: UIView = {
        let view = UIView()
        return view
    }()
    // UITableView
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    //    SearchBar
    private let searcBar: UISearchBar = {
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        search.showsCancelButton = true
        search.searchBarStyle = .default
        search.placeholder = " Search..."
        return search
    }()
    var onclick: Bool = true
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Country"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBack))
        view.backgroundColor = .systemBackground
        addUI()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.tableHeaderView = searcBar
//        searcBar.delegate = self
        tableViewSetup()
        countryInfo()
    }
    @objc func didTapBack(){
        self.dismiss(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func tableViewSetup(){
        if tag == 1{
            prefixtableViewSetUp()
            tableViewAnimate(load: true)
        }else if tag == 2{
            NationtableViewSetUp()
            tableViewAnimate(load: true)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if tag == 1 {
            view.endEditing(false)
            tableViewAnimate(load: true)
        } else if tag == 2 {
            view.endEditing(false)
            tableViewAnimate(load: true)
            textField.resignFirstResponder()
        }
        return true
    }
    func prefixtableViewSetUp () {
        tableView.frame =  CGRect(x: 20, y: view.frame.height - 10, width: view.frame.width - 5, height: view.frame.height - 20)
        tableView.layer.shadowColor  = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0.6, height: 0.5)
        tableView.layer.shadowOpacity = 2
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
//        tableView.register(PrefixTableViewCell.self,
//                           forCellReuseIdentifier: PrefixTableViewCell.identifier)
        tableView.tag = 1
        tableView.rowHeight = 80
    }
    func NationtableViewSetUp () {
        tableView.frame =  CGRect(x: 20, y: view.frame.height-10, width: view.frame.width - 5, height: view.frame.height - 20)
        tableView.layer.shadowColor  = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        tableView.layer.shadowOpacity = 2
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        tableView.layer.masksToBounds = true
        tableView.register(NationalityTableViewCell.self,
                           forCellReuseIdentifier: NationalityTableViewCell.identifier)
        tableView.tag = 2
        tableView.rowHeight = 50
    }
    //MARK: - AddSubViews
    func addUI() {
        view.addSubview(tableView)
    }
    func countryInfo(){
        apiManager.fetchCountryData { result in
            switch result  {
            case.success(let country):
                DispatchQueue.main.async {
                    self.countries = country
                    self.searchedCountries = self.countries
                    self.tableView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension CountryViewController {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchedCountries.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if tableView.tag == 1 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: PrefixTableViewCell.identifier, for: indexPath) as? PrefixTableViewCell else {
//                return UITableViewCell()
//            }
//            cell.layer.shadowOffset = CGSize(width: 0.6, height:0.6)
//            cell.layer.shadowOpacity = 0.4
//            cell.layer.cornerRadius = 10
//            cell.layer.masksToBounds = true
//            cell.backgroundColor = .clear
//            let prefix  = "+\(searchedCountries[indexPath.item].phonecode)(\(searchedCountries[indexPath.item].title))"
//            cell.keyLabel.text = prefix
//            let nationalityKey = ""
//            cell.titleLabel.text = nationalityKey
////            let image = searchedCountries[indexPath.item].flag
////            cell.countryImageView.sd_setImage(with: URL(string: image))
//
//            return cell
//        } else if tableView.tag == 2 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: NationalityTableViewCell.identifier, for: indexPath) as? NationalityTableViewCell else {
//                return UITableViewCell()
//            }
//            cell.layer.shadowOffset = CGSize(width: 0.6, height:0.6)
//            cell.layer.shadowOpacity = 0.4
//            cell.layer.cornerRadius = 10
//            cell.backgroundColor = .clear
//            cell.layer.masksToBounds = true
//            let nationTitle = searchedCountries[indexPath.row].title
//            cell.titleLabel.text = nationTitle
////            let image = searchedCountries[indexPath.item].flag
////            cell.countryImageView.sd_setImage(with: URL(string: image))
//            return cell
//        }
//        return UITableViewCell()
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableViewAnimate(load: false)
//        let prefix = "+"+( searchedCountries[indexPath.row].phonecode)
//        let nationality = "\(searchedCountries[indexPath.item].key)"
//        let nationalityTitle = "\(searchedCountries[indexPath.item].title)"
//        if tableView.tag == 1 {
//            DispatchQueue.main.async {
//                let data = self.completionHandler?(CountryData(key: nationality, title: nationalityTitle, phonecode: prefix))
//                print(data!)
//                self.dismiss(animated: true)
//            }
//        } else if tableView.tag == 2 {
//            DispatchQueue.main.async {
//                let data = self.completionHandler?(CountryData(key: nationality, title: nationalityTitle, phonecode: prefix))
//                print(data!)
//                self.dismiss(animated: true)
//            }
//        }
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Searched Text\(searchText)")
        self.searchedCountries = searchText.isEmpty ? countries : countries.filter({ model in
            return model.title.range(of: searchText, options: .caseInsensitive) != nil
        })
        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    func tableViewAnimate(load: Bool) {
        if load {
            UIView.animate(withDuration: 0.2) {
                self.tableView.frame = CGRect(x: 0,y: 100,width: self.view.frame.width,height: self.view.frame.height)
                self.view.backgroundColor = .lightGray
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.tableView.frame = CGRect(x: 20,
                                              y: self.view.frame.height,
                                              width: self.view.frame.width - 40,
                                              height: self.view.frame.height - 170)
                self.view.backgroundColor = .systemBackground
                self.view.endEditing(true)
            }
        }
    }
}
