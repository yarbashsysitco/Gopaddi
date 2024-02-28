//
//  FlightListTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit

class FlightListTableViewCell: UITableViewCell {
    
        static let identifier = "FlightListTableViewCell"
        let headerView: UIView = {
            let view = UIView()
            view.backgroundColor = .tertiarySystemBackground
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private let ImageView: UIImageView = {
            let imageview = UIImageView()
            imageview.translatesAutoresizingMaskIntoConstraints = false
            imageview.contentMode = .scaleAspectFill
            //        imageview.backgroundColor = .systemGray2
            imageview.image = UIImage(named: "flower")
            //        imageview.layer.cornerRadius = imageview.frame.width/2
            return imageview
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.text = "Canada Airlines"
            label.font = UIFont(name: "Poppins-SemiBold", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let subTitleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .systemGray
            label.text = "WY-610 WY-223"
            label.numberOfLines = 0
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let priceLabel: UILabel = {
            let label = UILabel()
            label.textColor = .systemBlue
            label.text = "900 NGN"
            label.font = UIFont(name: "Poppins-SemiBold", size: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(FlightListInTableViewCell.self, forCellReuseIdentifier: FlightListInTableViewCell.identifier)
            tableView.backgroundColor = .secondarySystemBackground
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(headerView)
            headerView.addSubview(ImageView)
            headerView.addSubview(titleLabel)
            headerView.addSubview(subTitleLabel)
            headerView.addSubview(priceLabel)
            headerView.addSubview(tableView)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
            
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                headerView.heightAnchor.constraint(equalToConstant: 250),
                
                ImageView.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 15),
                ImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                ImageView.widthAnchor.constraint(equalToConstant: 40),
                ImageView.heightAnchor.constraint(equalToConstant: 40),
                
                titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 15),
                titleLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor,constant: 10),
                
                subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
                subTitleLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor,constant: 10),
                
                priceLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 15),
                priceLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -15),
                
                tableView.topAnchor.constraint(equalTo: ImageView.bottomAnchor,constant: 10),
                tableView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 10),
                tableView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -10),
                tableView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor  ,constant: -10),
            ])
        }
        
        func configure(hotelList : HotelList) {
            
            
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }

    extension FlightListTableViewCell: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightListInTableViewCell.identifier, for: indexPath) as? FlightListInTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .tertiarySystemBackground
            //               cell.configure(hotelList: (hotelLists?[indexPath.row])!)
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }

    }



//{
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FlightListTableCell else {
//        return UITableViewCell()
//    }
//    
//    if let flightResult = Flightsearch?.result[indexPath.row] {
//        // Assuming "OperatingAirline_Text" is an array of strings
//        if let firstOneway = flightResult.onewaydata.first {
//            // Join the array of strings into a single string
//            if let operatingAirlines = firstOneway.OperatingAirline_Text {
//                // Display the first string only
//                if let firstAirline = operatingAirlines.first {
//                    cell.flightNameLb.text = firstAirline
//                }
//            }
//            
//            // Set TotalFare value to totalPriceLb
//            if let totalFare = firstOneway.TotalFare, let currencyCode = firstOneway.CurrencyCode {
//                let roundedTotalFare = Int(totalFare.rounded()) // Round the TotalFare to the nearest integer
//                cell.totalPriceLb.text = "\(roundedTotalFare) \(currencyCode)"
//            }
//            
//            if let operatingAirlineCode = firstOneway.OperatingAirline_Code,
//               let airlineFlightNumber = firstOneway.OperatingAirline_FlightNumber {
//                // Display the first character of OperatingAirlineCode if it's not an empty string
//                //                    if let firstAirline = operatingAirlineCode.first, let flightNum = airlineFlightNumber.first {
//                //                        cell.flightCodeLb.text = "\(firstAirline)-\(flightNum)"
//                //                    }
//                
//                if operatingAirlineCode.indices.contains(1), airlineFlightNumber.indices.contains(1) {
//                    if let firstAirline = operatingAirlineCode.first, let flightNum = airlineFlightNumber.first {
//                        let secondAirline = operatingAirlineCode[1]
//                        let secondFlightNum = airlineFlightNumber[1]
//                        
//                        let thirdAirline = operatingAirlineCode.indices.contains(2) ? operatingAirlineCode[2] : nil
//                        let thirdFlightNum = airlineFlightNumber.indices.contains(2) ? airlineFlightNumber[2] : nil
//                        
//                        let firstPart = "\(firstAirline)-\(flightNum)"
//                        let secondPart = "\(secondAirline)-\(secondFlightNum)"
//                        let thirdPart = thirdAirline != nil && thirdFlightNum != nil ? "\(thirdAirline!)-\(thirdFlightNum!)" : ""
//                        
//                        cell.flightCodeLb.text = "\(firstPart) \(secondPart) \(thirdPart)"
//
//                    }
//                }
//            }
//            
//            if let operatingAirlineImage = firstOneway.OperatingAirline_Image,
//               let AirlineImage = operatingAirlineImage.first,
//               let imageURL = URL(string: AirlineImage) {
//                // Assuming cell.coutryImage is a UIImageView
//                cell.coutryImage.sd_setImage(with: imageURL, completed: nil) // using sdwebimage for async image loading
//            }
//            
//            if let departureTimes = firstOneway.DepartureDateTime {
//                if let firstDepartureTime = departureTimes.first {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//                    
//                    if let date = dateFormatter.date(from: firstDepartureTime) {
//                        dateFormatter.dateFormat = "HH:mm"
//                        let timeString = dateFormatter.string(from: date)
//                        cell.oneWayDeparturTimeLb.text = timeString
//                        tableviews.reloadData()
//
//                    }
//                }
//            }
//            if let departureDate = firstOneway.DepartureDateTime {
//                if let departureDates = departureDate.first {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//                    
//                    if let date = dateFormatter.date(from: departureDates) {
//                        dateFormatter.dateFormat = "dd MMM, EEE"
//                        let timeString = dateFormatter.string(from: date)
//                        cell.oneWayDeparturDateLb.text = timeString
//                        tableviews.reloadData()
//
//                    }
//                }
//            }
//            
//            
//            if let arrivalTimes = firstOneway.ArrivalDateTime {
//                if let arrivalTime = arrivalTimes.first {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//                    
//                    if let date = dateFormatter.date(from: arrivalTime) {
//                        dateFormatter.dateFormat = "HH:mm"
//                        let timeString = dateFormatter.string(from: date)
//                        cell.oneWayArrivalTimeLb.text = timeString
//                        tableviews.reloadData()
//
//                    }
//                }
//            }
//            
//            if let arrivalDates = firstOneway.ArrivalDateTime {
//                if let arrivalDate = arrivalDates.first {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//                    
//                    if let date = dateFormatter.date(from: arrivalDate) {
//                        dateFormatter.dateFormat = "dd MMM, EEE"
//                        let timeString = dateFormatter.string(from: date)
//                        cell.oneWayArrivalDateLb.text = timeString
//
//                    }
//                }
//            }
//
//        }
//    }
//    
//    return cell
//    
//}
