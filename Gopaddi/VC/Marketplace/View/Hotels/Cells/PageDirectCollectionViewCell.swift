//
//  PageDirectCollectionViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class PageDirectCollectionViewCell: UICollectionViewCell {
        static let identifier = "PageDirectCollectionViewCell"
        let headerView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .secondarySystemBackground
            return view
        }()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "Poppins-Regular", size: 10)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private let ImageView: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
//            image.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(headerView)
            headerView.addSubview(ImageView)
            headerView.addSubview(titleLabel)
        }
       
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                
                headerView.topAnchor.constraint(equalTo:contentView.topAnchor, constant:0),
                headerView.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant:0),
                headerView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant:0),
                headerView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: 0),
                
                ImageView.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 7),
                ImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
    //            ImageView.leadingAnchor.constraint(equalTo:headerView.leadingAnchor, constant: 5),
                ImageView.heightAnchor.constraint(equalToConstant: 20),
                ImageView.widthAnchor.constraint(equalToConstant: 20),
                
                titleLabel.topAnchor.constraint(equalTo:ImageView.bottomAnchor, constant: 5),
                titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                titleLabel.widthAnchor.constraint(equalToConstant: 50),
            ])
        }
        func config(name : String , image : String){
            ImageView.image = UIImage(named: image)?.withTintColor(.label, renderingMode: .alwaysTemplate)
            titleLabel.text = name
        }
    }


