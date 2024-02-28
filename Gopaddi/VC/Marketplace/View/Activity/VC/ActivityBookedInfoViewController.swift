//
//  ActivityBookedInfoViewController.swift
//  Birdview Travels
//
//  Created by jizan k on 01/05/23.
//

import UIKit

class ActivityBookedInfoViewController: UIViewController {
    var key = String()
    var redirect : ActivityRedirect?
        private let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.indicatorStyle = .white
            return scrollView
        }()
        // contenView
        private let contenView: UIView = {
            let view = UIView()
            view.backgroundColor = .secondarySystemBackground
            return view
        }()
    let paymentHeadLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment Details"
        label.font = UIFont(name: "Poppins-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Regular", size: 17)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    var travellerCount: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Regular", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let lineView1: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray2
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let refHeadLabel: UILabel = {
            let label = UILabel()
            label.text = "Refernce"
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let refernceLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let totalHeadLabel: UILabel = {
            let label = UILabel()
            label.text = "Total"
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
         
        let totalLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Regular", size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    private let homeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back to home page", for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
        override func viewDidLoad() {
            super.viewDidLoad()
         title = "Activity"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            view.backgroundColor = .systemBackground
            scrollView.frame = CGRect(x: 0, y: 10, width: view.frame.size.width, height: view.frame.size.height)
            scrollView.contentSize = CGSize(width: view.frame.size.width-40, height: view.frame.size.height+120)
            contenView.frame = scrollView.bounds
            view.addSubview(scrollView)
            scrollView.addSubview(contenView)
            contenView.addSubview(activityImageView)
            activityImageView.addSubview(nameView)
            nameView.addSubview(nameLabel)
            contenView.addSubview(travellerCount)
            contenView.addSubview(lineView1)
            contenView.addSubview(refernceLabel)
            contenView.addSubview(refHeadLabel)
            contenView.addSubview(totalLabel)
            contenView.addSubview(totalHeadLabel)
            contenView.addSubview(homeButton)
            contenView.addSubview(paymentHeadLabel)
            homeButton.addTarget(self, action: #selector(didTapHome), for: .touchUpInside)
            callApi()
        }
    @objc func didTapHome(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc ?? MainVC(), animated: true)
    }
    func callApi(){
        ApiManager.shared.activityRedirect(key: key){ result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.view.stopLoading()
                    self.redirect = model
                    if model.code == "200" {
                       let img = model.result[0].featureImage
                        self.activityImageView.sd_setImage(with: URL(string: img))
                        if Int(model.result[0].childs) == 0 {
                            self.travellerCount.text = model.result[0].adults + " Adults"
                        }else{
                            self.travellerCount.text = model.result[0].adults + " Adults & " + model.result[0].childs + "Children"
                        }
                            self.nameLabel.text = model.result[0].title
                            self.totalLabel.text = model.result[0].totalPrice + " " + model.result[0].currency
                            self.refernceLabel.text = model.result[0].reference
                        
                    }
                }
            case .failure(let error):
                self.view.stopLoading()
                print(error.localizedDescription)
            }
        }
    }
        @objc private func didTapBackButton(){
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                
                paymentHeadLabel.topAnchor.constraint(equalTo: contenView.safeAreaLayoutGuide.topAnchor, constant: 30),
                paymentHeadLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 10),
                paymentHeadLabel.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -10),
                
                activityImageView.topAnchor.constraint(equalTo: paymentHeadLabel.bottomAnchor, constant: 20),
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
             
                    travellerCount.topAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 30),
                travellerCount.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                
                lineView1.topAnchor.constraint(equalTo: travellerCount.bottomAnchor, constant: 20),
                lineView1.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                lineView1.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                lineView1.heightAnchor.constraint(equalToConstant: 1),
                
                refHeadLabel.topAnchor.constraint(equalTo: lineView1.bottomAnchor, constant: 20),
                refHeadLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                
                
                refernceLabel.topAnchor.constraint(equalTo: lineView1.bottomAnchor, constant: 20),
                refernceLabel.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                refernceLabel.widthAnchor.constraint(equalToConstant: 150),
                
                totalHeadLabel.topAnchor.constraint(equalTo: refHeadLabel.bottomAnchor, constant: 20),
                totalHeadLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                
                totalLabel.topAnchor.constraint(equalTo: refernceLabel.bottomAnchor, constant: 20),
                totalLabel.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                totalLabel.widthAnchor.constraint(equalToConstant: 150),
                
                homeButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 250),
                homeButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
                homeButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
                homeButton.heightAnchor.constraint(equalToConstant: 48),
                
            ])
            
        }
    }


