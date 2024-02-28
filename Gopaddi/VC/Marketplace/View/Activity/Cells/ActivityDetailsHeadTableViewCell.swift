//
//  ActivityDetailsHeadTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.

import UIKit
import SDWebImage
class ActivityDetailsHeadTableViewCell: UITableViewCell {
        static let identifier = "ActivityDetailsHeadTableViewCell"
        var images : [MultiImage]?
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
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 1
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.register(ActivityDetailsCollectionViewCell.self, forCellWithReuseIdentifier: ActivityDetailsCollectionViewCell.identfier)
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()
        let nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.numberOfLines = 3
            label.font = UIFont(name: "Poppins-SemiBold", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let dateView: UIView = {
            let view = UIView()
            view.backgroundColor = .secondarySystemBackground
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let dateImageView: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.image = UIImage(systemName: "clock")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        let dateHourLabel: UILabel = {
            let label = UILabel()
            label.text = "6 hours"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let dateDayLabel: UILabel = {
            let label = UILabel()
            label.text = "0 days"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let safeView: UIView = {
            let view = UIView()
            view.backgroundColor = .secondarySystemBackground
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let safeImageView: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.image = UIImage(systemName: "plus.rectangle.portrait")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        let safeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "Safety measures"
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        let picupView: UIView = {
            let view = UIView()
            view.backgroundColor = .secondarySystemBackground
            //        view.backgroundColor = .systemGray5
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let picupImageView: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.image = UIImage(systemName: "car")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        let picupLabel: UILabel = {
            let label = UILabel()
            label.text = "Hotel pickup"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()

        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(headerView)
            headerView.addSubview(headerImageView)
            headerView.addSubview(titleLabel)
            headerView.addSubview(collectionView)
            headerView.addSubview(lineView1)
            headerView.addSubview(dateView)
            dateView.addSubview(dateImageView)
            dateView.addSubview(dateDayLabel)
            headerView.addSubview(safeView)
            safeView.addSubview(safeLabel)
            safeView.addSubview(safeImageView)
            headerView.addSubview(picupView)
            picupView.addSubview(picupLabel)
            picupView.addSubview(picupImageView)
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
                headerView.heightAnchor.constraint(equalToConstant: 270),
                
                headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
                headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                headerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                headerImageView.heightAnchor.constraint(equalToConstant: 180),
                
                collectionView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10),
                collectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                collectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor ,constant: -16),
                collectionView.heightAnchor.constraint(equalToConstant: 70),
                
                titleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -16),
                
                dateView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 16),
                dateView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                dateView.widthAnchor.constraint(equalToConstant: 100),
                dateView.heightAnchor.constraint(equalToConstant: 52),
                
                dateImageView.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
                dateImageView.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 5),
                dateImageView.heightAnchor.constraint(equalToConstant: 30),
                dateImageView.widthAnchor.constraint(equalToConstant: 30),

                dateDayLabel.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 15),
                dateDayLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: 10),

                safeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                safeView.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: 7),
                safeView.heightAnchor.constraint(equalToConstant: 52),
                safeView.widthAnchor.constraint(equalToConstant: 119),
                
                safeImageView.centerYAnchor.constraint(equalTo: safeView.centerYAnchor),
                safeImageView.leadingAnchor.constraint(equalTo: safeView.leadingAnchor, constant: 5),
                safeImageView.heightAnchor.constraint(equalToConstant: 25),
                safeImageView.widthAnchor.constraint(equalToConstant: 25),

                safeLabel.topAnchor.constraint(equalTo: safeView.topAnchor, constant: 10),
                safeLabel.leadingAnchor.constraint(equalTo: safeImageView.trailingAnchor, constant: 8),
                safeLabel.trailingAnchor.constraint(equalTo: safeView.trailingAnchor, constant: -3),

                picupView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor     , constant: 16),
                picupView.leadingAnchor.constraint(equalTo: safeView.trailingAnchor, constant: 12),
                picupView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
                picupView.heightAnchor.constraint(equalToConstant: 52),


    //            picupImageView.topAnchor.constraint(equalTo: picupView.topAnchor, constant: 12),
                picupImageView.centerYAnchor.constraint(equalTo: picupView.centerYAnchor),
                picupImageView.leadingAnchor.constraint(equalTo: picupView.leadingAnchor, constant: 5),
                picupImageView.heightAnchor.constraint(equalToConstant: 25),
                picupImageView.widthAnchor.constraint(equalToConstant: 25),

                picupLabel.topAnchor.constraint(equalTo: picupView.topAnchor, constant: 10),
                picupLabel.leadingAnchor.constraint(equalTo: picupImageView.trailingAnchor, constant: 8),
                picupLabel.trailingAnchor.constraint(equalTo: picupView.trailingAnchor, constant: -3),
               
            ])
        }
        
        func configure(image : String , name : String , imageList : [MultiImage] , duration : String) {
            headerImageView.sd_setImage(with: URL(string: image))
            titleLabel.text = name
            images = imageList
            dateDayLabel.text = duration
            collectionView.reloadData()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    extension ActivityDetailsHeadTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityDetailsCollectionViewCell.identfier, for: indexPath) as! ActivityDetailsCollectionViewCell
            cell.detailImageView.sd_setImage(with: URL(string: images?[indexPath.item].Image ?? ""))
            cell.layer.cornerRadius = 5
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images?.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            headerImageView.sd_setImage(with: URL(string: images?[indexPath.item].Image ?? "" ))
        }
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 85, height: 60)
        }
    }
