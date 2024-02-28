//
//  FilterStarCollectionViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class FilterStarCollectionViewCell: UICollectionViewCell {

        static let identifier = "FilterStarCollectionViewCell"
        
        let contenView: UIView = {
            let view = UIView()
            view.backgroundColor = .tertiarySystemBackground
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private let starLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-SemiBold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.layer.borderWidth = 0.1
            contentView.layer.cornerRadius = 16
    //        contentView.addSubview(contenView)
            contentView.addSubview(starLabel)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
               
                starLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                starLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
        }
        func config(name : String){
            starLabel.text = name
        }
    }
