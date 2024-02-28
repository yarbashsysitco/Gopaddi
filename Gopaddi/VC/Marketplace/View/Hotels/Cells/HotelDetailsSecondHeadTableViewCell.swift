//
//  HotelDetailsSecondHeadTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit
import Cosmos
class HotelDetailsSecondHeadTableViewCell: UITableViewCell {
            let secondHead = [
            DetailsHeadList(name: "Parking" ,image: "parking"),
            DetailsHeadList(name: "Wifi" ,image: "wifi"),
            DetailsHeadList(name: "Service" ,image: "service"),
            DetailsHeadList(name: "Pool" ,image: "swimming"),
            DetailsHeadList(name: "Gym" ,image: "gym"),
            DetailsHeadList(name: "Bar" ,image: "bar")
            ]
            var isChecked: Bool = false
            var bookClicked : (() -> ())?
            static let identifier = "HotelDetailsSecondHeadTableViewCell"
            let headerView: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .systemBackground
                return view
            }()
            private let rateView : UIView = {
                let view = UIView()
                view.backgroundColor = .systemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            private let locationView : UIView = {
                let view = UIView()
                view.backgroundColor = .systemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            private let locationImage: UIImageView = {
                let imageview = UIImageView()
                imageview.translatesAutoresizingMaskIntoConstraints = false
                imageview.contentMode = .scaleAspectFill
                imageview.image = UIImage(named: "status")
                imageview.image?.withTintColor(.systemBlue, renderingMode: .alwaysTemplate)
                return imageview
            }()
            let locTitleLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "New Delhi"
                label.font = UIFont(name: "Poppins-Regular", size: 12)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            private let sepView : UIView = {
                let view = UIView()
                view.backgroundColor = .systemGray
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            let collectionView : UICollectionView = {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 1
                let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
                collection.translatesAutoresizingMaskIntoConstraints = false
                collection.backgroundColor = .systemBackground
                collection.register(PageDirectCollectionViewCell.self, forCellWithReuseIdentifier: PageDirectCollectionViewCell.identifier)
                return collection
            }()
    let rating = CosmosView()
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                contentView.backgroundColor = .systemBackground
                contentView.addSubview(headerView)
                headerView.addSubview(rateView)
                headerView.addSubview(locationView)
                locationView.addSubview(locationImage)
                locationView.addSubview(locTitleLabel)
                headerView.addSubview(sepView)
                headerView.addSubview(collectionView)
                rateView.addSubview(rating)
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.reloadData()
                rating.settings.emptyBorderWidth = 1
                rating.settings.emptyBorderColor = .systemGray
                rating.settings.filledColor = .systemBlue
                rating.settings.filledBorderColor = .systemBlue
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                    headerView.heightAnchor.constraint(equalToConstant: 120),
                    
                    rateView.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 10),
                    rateView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    rateView.heightAnchor.constraint(equalToConstant: 35),
                    rateView.widthAnchor.constraint(equalToConstant: 150),
                    
                    rating.centerXAnchor.constraint(equalTo: rateView.centerXAnchor),
                    rating.centerYAnchor.constraint(equalTo: rateView.centerYAnchor),
                    rating.heightAnchor.constraint(equalToConstant: 30),
                    rating.widthAnchor.constraint(equalToConstant: 140),

                    sepView.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 10),
                    sepView.leadingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: 10),
                    sepView.heightAnchor.constraint(equalToConstant: 45),
                    sepView.widthAnchor.constraint(equalToConstant: 1),

                    locationView.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 10),
                    locationView.leadingAnchor.constraint(equalTo: sepView.trailingAnchor, constant: 10),
                    locationView.heightAnchor.constraint(equalToConstant: 45),

                    locationImage.topAnchor.constraint(equalTo:locationView.topAnchor, constant: 10),
                    locationImage.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 10),
                    locationImage.heightAnchor.constraint(equalToConstant: 17),
                    locationImage.widthAnchor.constraint(equalToConstant: 17),

                    locTitleLabel.topAnchor.constraint(equalTo:locationView.topAnchor, constant: 10),
                    locTitleLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 10),
                    locTitleLabel.heightAnchor.constraint(equalToConstant: 20),
                    
                    collectionView.topAnchor.constraint(equalTo:locationView.bottomAnchor, constant: 10),
                    collectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                    collectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
                    collectionView.heightAnchor.constraint(equalToConstant: contentView.frame.width / 6 - 15),
                    
                ])
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
    func configure(location : String, rateValue : Double){
        locTitleLabel.text = location
        rating.rating = rateValue
    }
        }

        extension HotelDetailsSecondHeadTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return secondHead.count
            }
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageDirectCollectionViewCell.identifier, for: indexPath) as! PageDirectCollectionViewCell
                cell.config(name: secondHead[indexPath.row].name ?? "", image: secondHead[indexPath.row].image ?? ""  )
                return cell
            }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return  CGSize(width: contentView.frame.width / 6 - 15, height: contentView.frame.width  / 6 - 15)
            }
          
        }
