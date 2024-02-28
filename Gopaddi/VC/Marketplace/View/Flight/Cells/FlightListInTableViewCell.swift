//
//  FlightListInTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class FlightListInTableViewCell: UITableViewCell {

        static let identifier = "FlightListInTableViewCell"
            let headerView: UIView = {
                let view = UIView()
                view.backgroundColor = .tertiarySystemBackground
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            let timeLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "15:00 "
                label.font = UIFont(name: "Poppins-SemiBold", size: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let dateLabel: UILabel = {
                let label = UILabel()
                label.textColor = .systemGray
                label.text = "13 July, Sat"
                label.numberOfLines = 0
                label.font = UIFont(name: "Poppins-Regular", size: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
    let timeToLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "21:00"
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateToLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "13 July, Sat"
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "1h 10m"
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "nonstop"
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //let lineView: UIView = {
    //    let view = UIView()
    //    view.backgroundColor = .systemGray
    //    view.translatesAutoresizingMaskIntoConstraints = false
    //    return view
    //}()
        private let ImageView: UIImageView = {
            let imageview = UIImageView()
            imageview.translatesAutoresizingMaskIntoConstraints = false
            imageview.contentMode = .scaleAspectFit
            imageview.image = UIImage(named: "Line")
            return imageview
        }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                contentView.addSubview(headerView)
                headerView.addSubview(timeLabel)
                headerView.addSubview(timeToLabel)
                headerView.addSubview(dateLabel)
                headerView.addSubview(dateToLabel)
        headerView.addSubview(totTimeLabel)
        headerView.addSubview(typeLabel)
        headerView.addSubview(ImageView)
                
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                    headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                    headerView.heightAnchor.constraint(equalToConstant: 100),
                    
                    timeLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 28),
                    timeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                    timeLabel.widthAnchor.constraint(equalToConstant: 70),
                    
                    dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 5),
                    dateLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 15),
                    dateLabel.widthAnchor.constraint(equalToConstant: 80),
                    
                    ImageView.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 10),
                    ImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor,constant: 20),
                    ImageView.widthAnchor.constraint(equalToConstant: 60 ),
                    ImageView.heightAnchor.constraint(equalToConstant: 40),
                    
                    timeToLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 15),
                    timeToLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: 15),
                    timeToLabel.widthAnchor.constraint(equalToConstant: 70),
                    
                    dateToLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 5),
                    dateToLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor,constant: 15),
                    dateToLabel.widthAnchor.constraint(equalToConstant: 80),
                    
                    totTimeLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 15),
                    totTimeLabel.trailingAnchor.constraint(equalTo: headerView  .trailingAnchor, constant: -15),
                    
                    typeLabel.topAnchor.constraint(equalTo: totTimeLabel.bottomAnchor,constant: 5),
                    typeLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -15),
                  
                ])
            }
           
            func configure(hotelList : HotelList) {
                
                
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            

        }

