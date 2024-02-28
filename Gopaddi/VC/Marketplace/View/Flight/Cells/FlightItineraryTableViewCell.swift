//
//  FlightItineraryTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class FlightItineraryTableViewCell: UITableViewCell {

            static let identifier = "FlightItineraryTableViewCell"
            let headerView: UIView = {
                let view = UIView()
                view.backgroundColor = .tertiarySystemBackground
                view.layer.cornerRadius = 10
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
      
            let titleLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "Dubai (DXB)"
                label.font = UIFont(name: "Poppins-Regular", size: 12)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let dateLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "4, Jun,2023;8:00 PM"
                label.numberOfLines = 0
                label.font = UIFont(name: "Poppins-Regular", size: 12)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let typeLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.text = "FZ- 441(Economy)"
                label.font = UIFont(name: "Poppins-Regular", size: 12)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
        let placeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "Dubai,Dubai"
            label.font = UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let header2View: UIView = {
            let view = UIView()
            view.backgroundColor = .tertiarySystemBackground
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        let title2Label: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "Dubai (DXB)"
            label.font = UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let date2Label: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "4, Jun,2023;8:00 PM"
            label.numberOfLines = 0
            label.font = UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let type2Label: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "FZ- 441(Economy)"
            label.font = UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    let place2Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Dubai,Dubai"
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        private let flightImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "flightTravel")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        private let flightView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName:"airplane")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                contentView.addSubview(headerView)
                headerView.addSubview(titleLabel)
                headerView.addSubview(dateLabel)
                headerView.addSubview(typeLabel)
                headerView.addSubview(placeLabel)
                contentView.addSubview(header2View)
                contentView.addSubview(flightImageView)
                flightImageView.addSubview(flightView)
                header2View.addSubview(title2Label)
                header2View.addSubview(date2Label)
                header2View.addSubview(type2Label)
                header2View.addSubview(place2Label)
            }
            override func layoutSubviews() {
                super.layoutSubviews()
                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                    headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                    headerView.heightAnchor.constraint(equalToConstant: 150),
                    headerView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width/2 - 25),
                    
                    titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 15),
                    titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                  
                    dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15),
                    dateLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 15),
                    
                    typeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 15),
                    typeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 15),
                    
                    placeLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor,constant: 15),
                    placeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 15),
                    
                    flightImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                    flightImageView.leadingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
                    flightImageView.trailingAnchor.constraint(equalTo: header2View.leadingAnchor, constant: 10),
                    flightImageView.heightAnchor.constraint(equalToConstant: 15),
                    
                    flightView.centerYAnchor.constraint(equalTo: flightImageView.centerYAnchor),
                    flightView.centerXAnchor.constraint(equalTo: flightImageView.centerXAnchor),
                    flightView.widthAnchor.constraint(equalToConstant: 15),
                    flightView.heightAnchor.constraint(equalToConstant: 15),
                    
                    header2View.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                    header2View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                    header2View.heightAnchor.constraint(equalToConstant: 150),
                    header2View.widthAnchor.constraint(equalToConstant: contentView.frame.size.width/2 - 25),
                    
                    title2Label.topAnchor.constraint(equalTo: header2View.topAnchor,constant: 15),
                    title2Label.leadingAnchor.constraint(equalTo: header2View.leadingAnchor, constant: 15),
                  
                    date2Label.topAnchor.constraint(equalTo: title2Label.bottomAnchor,constant: 15),
                    date2Label.leadingAnchor.constraint(equalTo: header2View.leadingAnchor,constant: 15),
                    
                    type2Label.topAnchor.constraint(equalTo: date2Label.bottomAnchor,constant: 15),
                    type2Label.leadingAnchor.constraint(equalTo: header2View.leadingAnchor,constant: 15),
                    
                    place2Label.topAnchor.constraint(equalTo: type2Label.bottomAnchor,constant: 15),
                    place2Label.leadingAnchor.constraint(equalTo: header2View.leadingAnchor,constant: 15),


                ])
            }
            
            func configure(hotelList : HotelList) {
                
                
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
        }

        

