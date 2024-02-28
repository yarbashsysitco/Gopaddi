//
//  HotelFilterViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit
import RangeSeekSlider

class HotelFilterViewController: UIViewController {
   
        var delegate : HotelFilterInput?
        var price : String = " "
        let durations = ["Ascending","descending"]
        var value : Int = 1
        var priceR : String?
        var star : [Int] = []
        var minPrice = CGFloat()
        var maxPrice = CGFloat()
        var selectedIndex : Int?
        private let contentView : UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private let ApplyButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Apply", for: .normal)
            button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
            return button
        }()
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            //        layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 2
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.register(FilterStarCollectionViewCell.self, forCellWithReuseIdentifier: FilterStarCollectionViewCell.identifier)
            collection.backgroundColor = .systemGray5
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()
        private let priceRange: UILabel = {
            let label = UILabel()
            label.text = "Price Range"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let HotelNameLabel: UILabel = {
            let label = UILabel()
            label.text = "Hotel Name"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let starLabel: UILabel = {
            let label = UILabel()
            label.text = "Star Rating"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let titleLAbel: UILabel = {
            let label = UILabel()
            label.text = "Filter"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.separatorStyle = .none
            tableView.backgroundColor = .systemGray5
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(SortTableViewCell.self, forCellReuseIdentifier: SortTableViewCell.identifier)
            return tableView
        }()
        let rangeSeekSlider = RangeSeekSlider()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black.withAlphaComponent(0.5)
            rangeSeekSlider.lineHeight = 3
            view.addSubview(contentView)
            contentView.addSubview(titleLAbel)
            contentView.addSubview(rangeSeekSlider)
            contentView.addSubview(priceRange)
            contentView.addSubview(starLabel)
            contentView.addSubview(tableView)
            contentView.addSubview(HotelNameLabel)
            contentView.addSubview(collectionView)
            contentView.addSubview(ApplyButton)
            rangeSeekSlider.frame = CGRectMake(0, 0, view.frame.width-20, 50)
            rangeSeekSlider.maxValue = 100000
            rangeSeekSlider.minValue = 0
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.reloadData()
            rangeSeekSlider.translatesAutoresizingMaskIntoConstraints = false
            tableView.delegate = self
            tableView.dataSource = self
            ApplyButton.addTarget(self, action: #selector(didtapApply), for: .touchUpInside)
            
        }
        @objc func didtapApply(){
            let selectedMinValue = self.rangeSeekSlider.selectedMinValue
            var selectedMaxValue = self.rangeSeekSlider.selectedMaxValue
            if selectedMaxValue == 100 {
                selectedMaxValue = 100000
            }
            self.price = String(selectedMinValue.description) + "-" + String(selectedMaxValue.description)
            delegate?.inputData(prRange: price, value: value, star: star)
            self.dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                contentView.heightAnchor.constraint(equalToConstant: 620),
                
                titleLAbel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                titleLAbel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                titleLAbel.heightAnchor.constraint(equalToConstant: 45),
                
                priceRange.topAnchor.constraint(equalTo: titleLAbel.bottomAnchor, constant: 20),
                priceRange.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                
                rangeSeekSlider.topAnchor.constraint(equalTo: priceRange.bottomAnchor, constant: 10),
                rangeSeekSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                rangeSeekSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                rangeSeekSlider.heightAnchor.constraint(equalToConstant: 50),
                
                starLabel.topAnchor.constraint(equalTo: rangeSeekSlider.bottomAnchor, constant: 30),
                starLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                
                collectionView.topAnchor.constraint(equalTo: starLabel.bottomAnchor, constant: 30),
                collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                collectionView.heightAnchor.constraint(equalToConstant: 110),
                
                HotelNameLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
                HotelNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                
                tableView.topAnchor.constraint(equalTo: HotelNameLabel.bottomAnchor, constant: 20),
                tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                tableView.heightAnchor.constraint(equalToConstant: 100),
                
                ApplyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
                ApplyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                ApplyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                ApplyButton.heightAnchor.constraint(equalToConstant: 48),
            ])
        }
        
    }
    extension HotelFilterViewController: UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return durations.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortTableViewCell.identifier, for: indexPath) as? SortTableViewCell else {
                return UITableViewCell()
            }
            cell.checkButton.tag = indexPath.row
            cell.backgroundColor = .secondarySystemBackground
            value = 1
            if indexPath.row == 0 {
                cell.isChecked = true
                cell.checkButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            }else{
                cell.isChecked = false
                cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            
            }
                        cell.checked = {
                            let firstIndex = IndexPath(row: 0, section: 0)
                            let secondIndex = IndexPath(row: 1, section: 0)
                            guard let firstCell = tableView.cellForRow(at: firstIndex) as? SortTableViewCell, let secondCell = tableView.cellForRow(at: secondIndex) as? SortTableViewCell else {return}
                            if cell.checkButton.tag == 0{
                                self.value = 1
                                firstCell.checkButton.setImage(UIImage(systemName: "circle.inset.filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
                                secondCell.checkButton.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                            }
                            else if cell.checkButton.tag == 1{
                                secondCell.checkButton.setImage(UIImage(systemName: "circle.inset.filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
                                firstCell.checkButton.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                                self.value = 2
                            }
                        }
            let textPrice = durations[indexPath.row]
            cell.configureText(text: textPrice)
            
            
            return cell
        }
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! SortTableViewCell
            cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
    }
    extension HotelFilterViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterStarCollectionViewCell.identifier, for: indexPath) as! FilterStarCollectionViewCell
            cell.config(name: String(indexPath.item + 1) + " Star")
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.systemBlue.cgColor
            cell.backgroundColor = .tertiarySystemBackground
            cell.layer.cornerRadius = 10
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (view.bounds.width/3)-20, height: 48)
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //        collectionView.deselectItem(at: indexPath, animated: true)
            let cell = collectionView.cellForItem(at: indexPath) as! FilterStarCollectionViewCell
            cell.backgroundColor = .systemBlue
            star.append(indexPath.item + 1)
            
        }
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as! FilterStarCollectionViewCell
            cell.backgroundColor = .tertiarySystemBackground
        }
    }

