//
//  HotelDetailsHeadTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit
import SDWebImage
class HotelDetailsHeadTableViewCell: UITableViewCell {
                static let identifier = "HotelDetailsHeadTableViewCell"
                var images : [Image]?
                let headerView: UIView = {
                let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    return view
                }()
                private let lineView1 : UIView = {
                    let view = UIView()
                    view.backgroundColor = .systemGray
                    view.translatesAutoresizingMaskIntoConstraints = false
                    return view
                }()
                let headerImageView: UIImageView = {
                    let image = UIImageView()
                    image.contentMode = .scaleAspectFill
                    image.layer.masksToBounds = true
                    image.clipsToBounds = true
                    image.translatesAutoresizingMaskIntoConstraints = false
                    return image
                }()
                let titleLabel: UILabel = {
                    let label = UILabel()
                    label.textColor = .label
                    label.font = UIFont(name: "Poppins-Regular", size: 18)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    return label
                }()
                
                private let collectionView: UICollectionView = {
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    layout.minimumLineSpacing = 10
                    layout.minimumInteritemSpacing = 1
                    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
                    collection.register(HotelRoomImageCollectionViewCell.self, forCellWithReuseIdentifier: HotelRoomImageCollectionViewCell.identfier)
                    collection.translatesAutoresizingMaskIntoConstraints = false
                    return collection
                }()
                let nameLabel: UILabel = {
                    let label = UILabel()
                    label.textColor = .label
                    label.numberOfLines = 3
                    label.font = .systemFont(ofSize: 16, weight: .semibold)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    return label
                }()
                private let rateView : UIView = {
                    let view = UIView()
                    view.backgroundColor = .tertiarySystemBackground
                    view.translatesAutoresizingMaskIntoConstraints = false
                    return view
                }()
                private let locationView : UIView = {
                    let view = UIView()
                    view.backgroundColor = .systemGray
                    view.translatesAutoresizingMaskIntoConstraints = false
                    return view
                }()
              
                override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                    super.init(style: style, reuseIdentifier: reuseIdentifier)
                    contentView.addSubview(headerView)
                    headerView.addSubview(headerImageView)
                    headerView.addSubview(titleLabel)
                    headerView.addSubview(collectionView)
                    headerView.addSubview(lineView1)
                    collectionView.dataSource = self
                    collectionView.delegate = self
                    collectionView.reloadData()
                }
                override func layoutSubviews() {
                    super.layoutSubviews()
                    NSLayoutConstraint.activate([
                        headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                        headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        headerView.heightAnchor.constraint(equalToConstant: 325),
                        
                        headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
                        headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                        headerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                        headerImageView.heightAnchor.constraint(equalToConstant: 180),
                        
                        collectionView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10),
                        collectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                        collectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor ,constant: -16),
                        collectionView.heightAnchor.constraint(equalToConstant: 70),
                        
                        titleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
                        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                        titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -16),
                    ])
                }
                
                func configure(image : String , name : String , imageList : [Image]) {
                    headerImageView.sd_setImage(with: URL(string: image))
                    titleLabel.text = name
                    images = imageList
                    collectionView.reloadData()
                }
                required init?(coder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")
                }
            }

            extension HotelDetailsHeadTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
                func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelRoomImageCollectionViewCell.identfier, for: indexPath) as! HotelRoomImageCollectionViewCell
                    cell.detailImageView.sd_setImage(with: URL(string: images?[indexPath.item].url ?? ""))
                    cell.configureImage(imageName: images?[indexPath.item].url ?? "")
                    cell.layer.cornerRadius = 5
                    return cell
                }
                func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                    return images?.count ?? 0
                }
                func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                    headerImageView.sd_setImage(with: URL(string: images?[indexPath.item].url ?? "" ))
                }
                func collectionView(_ collectionView: UICollectionView,
                                    layout collectionViewLayout: UICollectionViewLayout,
                                    sizeForItemAt indexPath: IndexPath) -> CGSize {
                    return CGSize(width: 85, height: 60)
                }
            }

