//
//  HotelBookingDetailsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import UIKit

class HotelBookingDetailsViewController: UIViewController {
        var bookId = String()
        var delegate : CancelBooking?
        var hotelBookList : HotelBookListResult?
        var hotelCancel : HotelCancel?
        private let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.indicatorStyle = .white
            return scrollView
        }()
        private let contenView: UIView = {
            let view = UIView()
            view.backgroundColor = .secondarySystemBackground
            return view
        }()
        let activityImageView: UIImageView = {
            let imageview = UIImageView()
            imageview.translatesAutoresizingMaskIntoConstraints = false
            imageview.contentMode = .scaleToFill
            return imageview
        }()
        let nameView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        var nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Medium", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let dateLabel: UILabel = {
            let label = UILabel()
            label.text = "Booking Details"
            label.font = UIFont(name: "Poppins-Medium", size: 15)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let lineView1: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray2
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let leadTHeadLabel: UILabel = {
            let label = UILabel()
            label.text = "Lead Traveller Details"
            label.font = UIFont(name: "Poppins-Medium", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let leadTNameTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.font = UIFont(name: "Poppins-Regular", size: 12)
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray2.cgColor
            field.backgroundColor = .systemGray5
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        let leadEmailTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.font = UIFont(name: "Poppins-Regular", size: 12)
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray2.cgColor
            field.backgroundColor = .systemGray5
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        let leadPhTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.font = UIFont(name: "Poppins-Regular", size: 12)
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray2.cgColor
            field.backgroundColor = .systemGray5
            field.placeholder = "Hotel check-in date"
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        let hotelHeadLabel: UILabel = {
            let label = UILabel()
            label.text = "Hotel Details"
            label.font = UIFont(name: "Poppins-Medium", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let roomsLabel: UILabel = {
            let label = UILabel()
            label.text = "Total Rooms & Guests"
            label.font = UIFont(name: "Poppins-Regular", size: 10)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let roomTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.font = UIFont(name: "Poppins-Regular", size: 12)
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray2.cgColor
            field.backgroundColor = .systemGray5
            field.placeholder = "Hotel check-in date"
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        let hotelChekDateLabel: UILabel = {
            let label = UILabel()
            label.text = "Hotel Check-in Date"
            label.font = UIFont(name: "Poppins-Regular", size: 10)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let hotelChekDateTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.font = UIFont(name: "Poppins-Regular", size: 12)
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray2.cgColor
            field.backgroundColor = .systemGray5
            field.placeholder = "Hotel check-in date"
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        let hotelChekOutDateLabel: UILabel = {
            let label = UILabel()
            label.text = "Hotel Check-ut Date"
            label.font = UIFont(name: "Poppins-Regular", size: 10)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let hotelChekOutDateTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.font = UIFont(name: "Poppins-Regular", size: 12)
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.systemGray2.cgColor
            field.backgroundColor = .systemGray5
            field.placeholder = "Hotel check-Out date"
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        let cancelLabel: UILabel = {
            let label = UILabel()
            label.text = "Cancellation Policy"
            label.font = UIFont(name: "Poppins-Regular", size: 12)
            let labelTapGesture = UITapGestureRecognizer(target:HotelBookingDetailsViewController.self,action:#selector(didtapCancellation))
            label.addGestureRecognizer(labelTapGesture)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let cancelView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.systemGray2.cgColor
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let cancelPolicyLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 10
            label.font = UIFont(name: "Poppins-Regular", size: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let lineView2: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray2
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let totalLabel: UILabel = {
            let label = UILabel()
            label.text = "Total"
            label.textColor = .label
            label.font = UIFont(name: "Poppins-Medium", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let totalTF: UITextField = {
            let field =  TextFieldWithPadding()
            field.layer.borderWidth = 0.1
            field.autocorrectionType = .yes
            field.autocapitalizationType = .none
            field.textColor = .black
            field.font = UIFont(name: "Poppins-Medium", size: 14)
            field.layer.cornerRadius = 7
            field.backgroundColor = .white
            field.translatesAutoresizingMaskIntoConstraints = false
            return field
        }()
        private let cancelButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Cancel booking", for: .normal)
            button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
            return button
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Bookings"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            navigationItem.leftBarButtonItem?.tintColor = .systemBlue
            view.backgroundColor = .systemBackground
            scrollView.frame = CGRect(x: 0, y: 10, width: view.frame.size.width, height: view.frame.size.height + 100)
            scrollView.contentSize = CGSize(width: view.frame.size.width-40, height: view.frame.size.height + 200)
            contenView.frame = scrollView.bounds
            view.addSubview(scrollView)
            scrollView.addSubview(contenView)
            contenView.addSubview(activityImageView)
            activityImageView.addSubview(nameView)
            nameView.addSubview(nameLabel)
            contenView.addSubview(dateLabel)
            contenView.addSubview(lineView1)
            contenView.addSubview(leadTHeadLabel)
            contenView.addSubview(leadTNameTF)
            contenView.addSubview(leadEmailTF)
            contenView.addSubview(leadPhTF)
            contenView.addSubview(hotelHeadLabel)
            contenView.addSubview(roomTF)
            contenView.addSubview(hotelChekOutDateLabel)
            contenView.addSubview(hotelChekOutDateTF)
            contenView.addSubview(roomsLabel)
            contenView.addSubview(hotelChekDateLabel)
            contenView.addSubview(hotelChekDateTF)
            contenView.addSubview(cancelLabel)
            contenView.addSubview(cancelView)
            cancelView.addSubview(cancelPolicyLabel)
            contenView.addSubview(lineView2)
            contenView.addSubview(totalTF)
            contenView.addSubview(totalLabel)
            contenView.addSubview(cancelButton)
            loadDetails()
            cancelButton.addTarget(self, action: #selector(didTapCancelHotel), for:.touchUpInside )
        }
        @objc func didTapCancelHotel(){
            let alert = UIAlertController(title: "", message: "Are you sure want to Cancel this Booking?", preferredStyle: .alert)
            let oKBtn = UIAlertAction(title: "OK", style: .default) {_ in
                self.callCancelAPI()
                self.view.stopLoading()
                alert.dismiss(animated: true)
            }
            let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel){_ in
                alert.dismiss(animated: true)
            }
            alert.addAction(oKBtn)
            alert.addAction(cancelBtn)
            self.present(alert, animated: true)
        }
        private func callCancelAPI(){
            self.view.showLoading()
            ApiManager.shared.hotelCancel(hbId: (self.hotelBookList?.hb_id)!, scNumber: (self.hotelBookList?.hb_response[0].supplierConfirmationNum)!, rNumber: String((self.hotelBookList?.hb_response[0].referenceNum)!)){ result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.hotelCancel = model
                        if model.code == "200" {
                            let alert = UIAlertController(title: "", message: "Hotel Booking is deleted!", preferredStyle: .alert)
                            let delay = DispatchTime.now() + 4
                            DispatchQueue.main.asyncAfter(deadline: delay){
                                alert.dismiss(animated: true)
                                self.delegate?.bookingCancelled()
                                self.dismiss(animated: true)
                            }
                            self.present(alert, animated: true)
                        }else {
                            self.view.stopLoading()
                            let alert = UIAlertController(title: "", message: model.result, preferredStyle: .alert)
                            let delay = DispatchTime.now() + 4
                            DispatchQueue.main.asyncAfter(deadline: delay){
                                alert.dismiss(animated: true)
                                self.delegate?.bookingCancelled()
                                self.dismiss(animated: true)
                            }
                            self.present(alert, animated: true)
                        }
                    }
                case .failure(let error):
                    self.view.stopLoading()
                    print(error.localizedDescription)
                }
            }
        }
        @objc func didtapCancellation(){
            print("Tapped")
            cancelView.isHidden = true
        }
        func loadDetails(){
            let url = self.hotelBookList?.hotelImage
            self.activityImageView.sd_setImage(with: URL(string: url ?? ""))
            self.nameLabel.text = self.hotelBookList?.hotelName
            self.leadTNameTF.text = self.hotelBookList?.hb_contact[0].fname
            self.leadEmailTF.text = self.hotelBookList?.hb_contact[0].email
            self.leadPhTF.text = self.hotelBookList?.hb_contact[0].phone
            let adult = Int(self.hotelBookList!.hb_adults)
            let child = Int(self.hotelBookList!.hb_childs)
            self.roomTF.text = self.hotelBookList!.hb_rooms + " Rooms & " + String(adult ?? 0 + (child ?? 0)) + " Guests"
            self.hotelChekDateTF.text = self.hotelBookList?.hb_check_in
            self.hotelChekOutDateTF.text = self.hotelBookList?.hb_check_out
            self.totalTF.text =  self.hotelBookList!.hb_total + " " + self.hotelBookList!.hb_currency
            self.cancelPolicyLabel.text = self.hotelBookList?.hb_response[0].roomBookDetails.cancellationPolicy
        }
        @objc private func didTapBackButton(){
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                activityImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: contenView.safeAreaLayoutGuide.topAnchor, constant: 20),
                activityImageView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 10),
                activityImageView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -10),
                activityImageView.heightAnchor.constraint(equalToConstant: 250),
                
                nameView.bottomAnchor.constraint(equalTo: activityImageView.bottomAnchor, constant: -10),
                nameView.leadingAnchor.constraint(equalTo: activityImageView.leadingAnchor, constant: 10),
                nameView.trailingAnchor.constraint(equalTo: activityImageView.trailingAnchor, constant: -10),
                nameView.heightAnchor.constraint(equalToConstant: 50),
                
                nameLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
                nameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
                nameLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
                nameLabel.heightAnchor.constraint(equalToConstant: 48),
                
                dateLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 20),
                dateLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                
                lineView1.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                lineView1.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                lineView1.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                lineView1.heightAnchor.constraint(equalToConstant: 1),
                
                leadTHeadLabel.topAnchor.constraint(equalTo: lineView1.bottomAnchor, constant: 10),
                leadTHeadLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                
                leadTNameTF.topAnchor.constraint(equalTo: leadTHeadLabel.bottomAnchor, constant: 10),
                leadTNameTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                leadTNameTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                leadTNameTF.heightAnchor.constraint(equalToConstant: 43),
                
                leadEmailTF.topAnchor.constraint(equalTo: leadTNameTF.bottomAnchor, constant: 8),
                leadEmailTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                leadEmailTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                leadEmailTF.heightAnchor.constraint(equalToConstant: 43),
                
                leadPhTF.topAnchor.constraint(equalTo: leadEmailTF.bottomAnchor, constant: 8),
                leadPhTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                leadPhTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                leadPhTF.heightAnchor.constraint(equalToConstant: 43),
                
                hotelHeadLabel.topAnchor.constraint(equalTo: leadPhTF.bottomAnchor, constant: 15),
                hotelHeadLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                
                hotelChekDateLabel.topAnchor.constraint(equalTo: hotelHeadLabel.bottomAnchor, constant: 10),
                hotelChekDateLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                hotelChekDateLabel.widthAnchor.constraint(equalToConstant: contenView.frame.width/2 - 30),
                
                hotelChekOutDateLabel.topAnchor.constraint(equalTo: hotelHeadLabel.bottomAnchor, constant: 10),
                hotelChekOutDateLabel.leadingAnchor.constraint(equalTo: hotelChekDateLabel.trailingAnchor, constant: 25),
                hotelChekOutDateLabel.widthAnchor.constraint(equalToConstant: contenView.frame.width/2 - 30),
                
                hotelChekDateTF.topAnchor.constraint(equalTo: hotelChekDateLabel.bottomAnchor, constant: 3),
                hotelChekDateTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                hotelChekDateTF.heightAnchor.constraint(equalToConstant: 43),
                hotelChekDateTF.widthAnchor.constraint(equalToConstant: contenView.frame.width/2 - 30),
                
                hotelChekOutDateTF.topAnchor.constraint(equalTo: hotelChekOutDateLabel.bottomAnchor, constant: 3),
                hotelChekOutDateTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                hotelChekOutDateTF.heightAnchor.constraint(equalToConstant: 43),
                hotelChekOutDateTF.widthAnchor.constraint(equalToConstant: contenView.frame.width/2 - 30),
                
                roomsLabel.topAnchor.constraint(equalTo: hotelChekDateTF.bottomAnchor, constant: 10),
                roomsLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                
                roomTF.topAnchor.constraint(equalTo: roomsLabel.bottomAnchor, constant: 3),
                roomTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                roomTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                roomTF.heightAnchor.constraint(equalToConstant: 43),
                
                
                cancelLabel.topAnchor.constraint(equalTo: roomTF.bottomAnchor, constant: 10),
                cancelLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                cancelLabel.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                
                cancelView.topAnchor.constraint(equalTo: cancelLabel.bottomAnchor, constant: 10),
                cancelView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                cancelView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                
                cancelPolicyLabel.topAnchor.constraint(equalTo: cancelView.topAnchor, constant: 5),
                cancelPolicyLabel.leadingAnchor.constraint(equalTo: cancelView.leadingAnchor, constant: 15),
                cancelPolicyLabel.trailingAnchor.constraint(equalTo: cancelView.trailingAnchor, constant: -15),
                cancelPolicyLabel.bottomAnchor.constraint(equalTo: cancelView.bottomAnchor, constant: -5),
                
                lineView2.topAnchor.constraint(equalTo: cancelView.bottomAnchor, constant: 15),
                lineView2.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                lineView2.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                lineView2.heightAnchor.constraint(equalToConstant: 1),
                
                totalTF.topAnchor.constraint(equalTo: lineView2.bottomAnchor, constant: 10),
                totalTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                totalTF.widthAnchor.constraint(equalToConstant: 130),
                totalTF.heightAnchor.constraint(equalToConstant: 43),
                
                totalLabel.topAnchor.constraint(equalTo: lineView2.bottomAnchor, constant: 10),
                totalLabel.trailingAnchor.constraint(equalTo: totalTF.leadingAnchor, constant: 10),
                totalLabel.widthAnchor.constraint(equalToConstant: 100),
                totalLabel.heightAnchor.constraint(equalToConstant: 43),
                
                cancelButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 25),
                cancelButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 20),
                cancelButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -20),
                cancelButton.heightAnchor.constraint(equalToConstant: 48),
                
            ])
            
        }
    }




