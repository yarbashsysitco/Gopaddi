//
//  ActivityBookingSelectTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import UIKit

class ActivityBookingSelectTableViewCell: UITableViewCell {
                var isChecked: Bool = false
            static let identifier = "ActivityBookingSelectTableViewCell"
                let texttLabel: UILabel = {
                    let label = UILabel()
                    label.textColor = .label
                    label.font = UIFont(name: "Poppins-Regular", size: 14)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    return label
                }()
              
                override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                    super.init(style: style, reuseIdentifier: reuseIdentifier)
                    contentView.addSubview(texttLabel)
                }
              
                override func layoutSubviews() {
                    super.layoutSubviews()
                    NSLayoutConstraint.activate([
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

