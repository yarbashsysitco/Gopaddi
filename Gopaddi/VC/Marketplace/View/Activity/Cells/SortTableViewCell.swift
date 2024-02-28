//
//  SortTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit

class SortTableViewCell: UITableViewCell {
        var isChecked: Bool = false
        var checked : (() -> ())?
    static let identifier = "SortTableViewCell"
        let checkButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "circle"), for: .normal)
            button.backgroundColor = .secondarySystemBackground
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        let texttLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
      
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(checkButton)
            
            contentView.addSubview(texttLabel)
                checkButton.addTarget(self, action: #selector(didTapCheckBoxButton), for: .touchUpInside)
            
        }
        @objc func didTapCheckBoxButton() {
            checked?()
//            if (isChecked == false)
//            {
//                UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
//                    self.checkButton.layer.borderColor = UIColor.blue.cgColor
//                    self.checkButton.setImage(UIImage(systemName: "circle.inset.filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
//    //                self.checkButton.imageView?.tintColor = .white
//                    self.isChecked = true
//           }
//            }
//            else {
//                UIView.animate(withDuration: 0.5, delay: 0) {
//                    self.checkButton.layer.borderColor = UIColor.systemGray2.cgColor
//                    self.checkButton.backgroundColor = .secondarySystemBackground
//                    self.isChecked = false
//           }
//            }
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                checkButton.heightAnchor.constraint(equalToConstant: 20),
                checkButton.widthAnchor.constraint(equalToConstant: 20),
             
                texttLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
                texttLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               
            ])
        }
        func configureText(text: String) {
            texttLabel.text = text
           
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
