//
//  HotelConfiredInfoViewController.swift
//  Gopaddi
//
//  Created by jizan k on 19/07/23.
//

import UIKit

class HotelConfiredInfoViewController: UIViewController {

    private let tableView : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.register(HotelConfirmedInfoTableViewCell.self , forCellReuseIdentifier: HotelConfirmedInfoTableViewCell.identifier)
        table.register(HotelConfirmPreviewHeadTableViewCell.self , forCellReuseIdentifier: HotelConfirmPreviewHeadTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        return table
    }()
    
    var key = String()
    var redirect : ActivityRedirect?
    override func viewDidLoad (){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.parent?.title = "Hotels"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
        tableView.reloadData()
        navigationItem.leftBarButtonItem?.tintColor = .systemGray
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
//        callApi()
    }
//    func callApi(){
//        ApiManager.shared.hotelRedirect(key: key){ result in
//            switch result {
//            case .success(let model):
//                DispatchQueue.main.async {
//                    self.view.stopLoading()
//                    if model.code == "200" {
//                        self.redirect = model
//                        self.tableView.reloadData()
//                    }else{
//                        let alert = UIAlertController(title: "Sorry!", message: "Something went wrong", preferredStyle: .alert)
//                        let okBtn = UIAlertAction(title: "Ok", style: .cancel){_ in
//                            alert.dismiss(animated: true)
//                        }
//                        alert.addAction(okBtn)
//                        self.present(alert, animated: true)
//                    }
//                }
//            case .failure(let error):
//                self.view.stopLoading()
//                print(error.localizedDescription)
//            }
//        }
//    }
   
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
extension HotelConfiredInfoViewController : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
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
//            if let redirect = redirect {
//                cell.config(model: redirect)
//            }
//            cell.gotoHomeClicked = {
//                let vc =  MainViewController()
//                                let navVc = UINavigationController(rootViewController: vc)
//                                navVc.modalPresentationStyle = .fullScreen
//                self.present(navVc, animated: true)
//            }
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

