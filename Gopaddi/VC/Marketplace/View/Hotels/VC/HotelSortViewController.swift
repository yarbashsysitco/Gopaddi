//
//  HotelSortViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class HotelSortViewController: UIViewController {
        let priceSection = "Sort By"
        let priceText = ["Popularily","Price(Low to High)","Price(High to Low)","User Rating(Highest)"]
        var sortValue : Int = 1
        var delegate : HotelsortInfo?
        private let contentView : UIView = {
            let view = UIView()
            view.layer.cornerRadius = 25
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.systemGray2.cgColor
            view.backgroundColor = .secondarySystemBackground
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private let outerView : UIView = {
            let view = UIView()
            view.backgroundColor = .secondarySystemBackground
            view.layer.cornerRadius = 25
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Sort By"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let closeButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "close"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.separatorStyle = .none
            tableView.register(SortTableViewCell.self, forCellReuseIdentifier: SortTableViewCell.identifier)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
            view.addSubview(outerView)
            outerView.addSubview(contentView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(closeButton)
            contentView.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        }
        @objc func didTapClose(){
            self.dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                
                outerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                outerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                outerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                outerView.heightAnchor.constraint(equalToConstant: 300),
                
                contentView.topAnchor.constraint(equalTo: outerView.topAnchor,constant: 10),
                contentView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor,constant: 10),
                contentView.trailingAnchor.constraint(equalTo: outerView.trailingAnchor,constant: -10),
                contentView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                
                closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                closeButton.heightAnchor.constraint(equalToConstant: 35),
                closeButton.widthAnchor.constraint(equalToConstant: 35),
                
                tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
            ])
        }
        @objc private func tappedReset() {
            
        }
        @objc private func tappedDone() {
            self.dismiss(animated: true)
        }
    }
    extension HotelSortViewController: UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return priceText.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortTableViewCell.identifier, for: indexPath) as? SortTableViewCell else {
                return UITableViewCell()
            }
            cell.checked = {
                if indexPath.row == 0{
                    self.sortValue = 1
                }else if indexPath.row == 1{
                    self.sortValue = 2
                }
                if indexPath.row == 2{
                    self.sortValue = 3
                }else if indexPath.row == 3{
                    self.sortValue = 4
                }
                self.delegate?.sortDetails(sortValue: self.sortValue)
                self.dismiss(animated: false)
            }
            let textPrice = priceText[indexPath.row]
            cell.configureText(text: textPrice)
            
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
