//
//  HotelRoomImageCollectionViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class HotelRoomImageCollectionViewCell: UICollectionViewCell {
    static let identfier = "HotelRoomImageCollectionViewCell"
            let detailImageView: UIImageView = {
                let image = UIImageView()
                image.contentMode = .scaleToFill
                image.layer.cornerRadius = 5
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            override init(frame: CGRect) {
                super.init(frame: frame)
                contentView.addSubview(detailImageView)
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
                    detailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
                    detailImageView.heightAnchor.constraint(equalToConstant: 60),
                    detailImageView.widthAnchor.constraint(equalToConstant: 85),
                ])
            }
            func configureImage(imageName: String) {
                detailImageView.sd_setImage(with: URL(string: imageName))
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
