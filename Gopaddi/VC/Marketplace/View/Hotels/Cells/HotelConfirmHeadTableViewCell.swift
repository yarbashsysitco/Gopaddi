//
//  HotelConfirmHeadTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit

class HotelConfirmHeadTableViewCell: UITableViewCell {
 
        static let identifier = "HotelConfirmHeadTableViewCell"
        let headerView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.alignment = .center
            view.distribution = .fillEqually
            view.spacing =  40
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            return view
        }()
        let no1View: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 20
            view.layer.borderColor = UIColor.systemBlue.cgColor
            view.layer.borderWidth = 1
            view.backgroundColor = .systemBlue
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let no2View: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 20
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBlue
            return view
        }()
        let no3View: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 20
            view.layer.borderColor = UIColor.systemBlue.cgColor
            view.layer.borderWidth = 1
            view.backgroundColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let no4View: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 20
            view.layer.borderColor = UIColor.systemBlue.cgColor
            view.layer.borderWidth = 1
            view.backgroundColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let lineView1: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBlue
            return view
        }()
        let lineView2: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBlue
            return view
        }()
        let titleLabel1: UILabel = {
            let label = UILabel()
            label.text = "Review Hotel"
            label.textAlignment = .center
            label.textColor = .systemGray2
            label.font =  UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let titleLabel2: UILabel = {
            let label = UILabel()
            label.text = "User Details"
            label.textAlignment = .center
            label.textColor = .systemGray2
            label.font =  UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let titleLabel3: UILabel = {
            let label = UILabel()
            label.text = "Payment"
            label.textAlignment = .center
            label.textColor = .systemGray2
            label.font =  UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let titleLabel4: UILabel = {
            let label = UILabel()
            label.text = "Confirmation"
            label.textAlignment = .center
            label.textColor = .systemGray2
            label.font =  UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let tickImageView: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.clipsToBounds = true
            image.backgroundColor = .systemBlue
            image.layer.masksToBounds = true
            image.image = UIImage(named: "tick")
            image.layer.cornerRadius = 20
            return image
        }()
        let noLabel2: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = "2"
            label.textAlignment = .center
            label.font =  UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let noLabel3: UILabel = {
            let label = UILabel()
            label.textColor = .systemBlue
            label.text = "3"
            label.textAlignment = .center
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let noLabel4: UILabel = {
            let label = UILabel()
            label.textColor = .systemBlue
            label.textAlignment = .center
            label.text = "4"
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let adultLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Regular", size: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.backgroundColor = .systemBackground
            contentView.addSubview(headerView)
            headerView.addSubview(no1View)
            headerView.addSubview(no2View)
            headerView.addSubview(no3View)
            headerView.addSubview(no4View)
            headerView.addSubview(lineView1)
            headerView.addSubview(lineView2)
            headerView.addSubview(no2View)
            headerView.addSubview(no3View)
            headerView.addSubview(no4View)
            no2View.addSubview(noLabel2)
            no3View.addSubview(noLabel3)
            no4View.addSubview(noLabel4)
            headerView.addSubview(titleLabel1)
            headerView.addSubview(titleLabel2)
            headerView.addSubview(titleLabel3)
            headerView.addSubview(titleLabel4)
            no1View.addSubview(tickImageView)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            NSLayoutConstraint.activate([
                headerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                headerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                headerView.widthAnchor.constraint(equalToConstant: 400),
                headerView.heightAnchor.constraint(equalToConstant: 160),
                
                lineView2.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                lineView2.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 80),
                lineView2.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -60),
                lineView2.heightAnchor.constraint(equalToConstant: 1),
                
                no1View.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                no1View.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 50),
                no1View.heightAnchor.constraint(equalToConstant: 40),
                no1View.widthAnchor.constraint(equalToConstant: 40),
                
                tickImageView.centerYAnchor.constraint(equalTo: no1View.centerYAnchor),
                tickImageView.centerXAnchor.constraint(equalTo: no1View.centerXAnchor),
                tickImageView.heightAnchor.constraint(equalToConstant: 25),
                tickImageView.widthAnchor.constraint(equalToConstant: 25),
                
                noLabel2.centerYAnchor.constraint(equalTo: no2View.centerYAnchor),
                noLabel2.centerXAnchor.constraint(equalTo: no2View.centerXAnchor),
                noLabel2.widthAnchor.constraint(equalToConstant: 40),
                
                titleLabel1.topAnchor.constraint(equalTo: no1View.bottomAnchor, constant: 5),
                titleLabel1.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
                titleLabel1.widthAnchor.constraint(equalToConstant: 80),
                
                no2View.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                no2View.leadingAnchor.constraint(equalTo: no1View.trailingAnchor, constant: 45),
                no2View.heightAnchor.constraint(equalToConstant: 40),
                no2View.widthAnchor.constraint(equalToConstant: 40),
                
                titleLabel2.topAnchor.constraint(equalTo: no2View.bottomAnchor, constant: 5),
                titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor, constant: 5),
                titleLabel2.widthAnchor.constraint(equalToConstant: 80),
                
                noLabel2.centerYAnchor.constraint(equalTo: no2View.centerYAnchor),
                noLabel2.centerXAnchor.constraint(equalTo: no2View.centerXAnchor),
                noLabel2.widthAnchor.constraint(equalToConstant: 40),
                
                no3View.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                no3View.leadingAnchor.constraint(equalTo: no2View.trailingAnchor, constant: 45),
                no3View.heightAnchor.constraint(equalToConstant: 40),
                no3View.widthAnchor.constraint(equalToConstant: 40),
                
                titleLabel3.topAnchor.constraint(equalTo: no3View.bottomAnchor, constant: 5),
                titleLabel3.leadingAnchor.constraint(equalTo: titleLabel2.trailingAnchor, constant: 5),
                titleLabel3.widthAnchor.constraint(equalToConstant: 80),
                
                noLabel3.centerYAnchor.constraint(equalTo: no3View.centerYAnchor),
                noLabel3.centerXAnchor.constraint(equalTo: no3View.centerXAnchor),
                noLabel3.widthAnchor.constraint(equalToConstant: 40),
                
                no4View.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                no4View.leadingAnchor.constraint(equalTo: no3View.trailingAnchor, constant: 45),
                no4View.heightAnchor.constraint(equalToConstant: 40),
                no4View.widthAnchor.constraint(equalToConstant: 40),
                
                titleLabel4.topAnchor.constraint(equalTo: no4View.bottomAnchor, constant: 5),
                titleLabel4.leadingAnchor.constraint(equalTo: titleLabel3.trailingAnchor, constant: 5),
                titleLabel4.widthAnchor.constraint(equalToConstant: 80),
                
                noLabel4.centerYAnchor.constraint(equalTo: no4View.centerYAnchor),
                noLabel4.centerXAnchor.constraint(equalTo: no4View.centerXAnchor),
                noLabel4.widthAnchor.constraint(equalToConstant: 40),
                
                
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }



