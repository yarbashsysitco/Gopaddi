//
//  HotelBookedInfoViewController.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import UIKit

class HotelBookedInfoViewController: UIViewController {
    
    var key = String()
    var redirect : HotelRedirect?
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
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
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
        label.font = UIFont(name: "Poppins-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let leadTNameTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 10
        field.textColor = .black
        field.font = UIFont(name: "Poppins-Regular", size: 12)
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.systemGray2.cgColor
        field.backgroundColor = .white
        field.placeholder = "Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let leadEmailTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 10
        field.textColor = .black
        field.font = UIFont(name: "Poppins-Regular", size: 12)
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.systemGray2.cgColor
        field.backgroundColor = .white
        field.placeholder = "Email"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let leadPhTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 10
        field.textColor = .black
        field.font = UIFont(name: "Poppins-Regular", size: 12)
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.systemGray2.cgColor
        field.backgroundColor = .white
        field.placeholder = "Phone Number"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.textColor = .black
        field.font = UIFont(name: "Poppins-Regular", size: 14)
        field.layer.cornerRadius = 7
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let goToHomepageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Homepage", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        goToHomepageButton.addTarget(self, action: #selector(goToHomepageButtonTapped), for: .touchUpInside)
        title = "Hotel"
        scrollView.isScrollEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        scrollView.frame = CGRect(x: 0, y: 10, width: view.frame.size.width, height: view.frame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width-40, height: view.frame.size.height+120)
        contenView.frame = scrollView.bounds
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(leadTHeadLabel)
        contenView.addSubview(leadTNameTF)
        contenView.addSubview(leadEmailTF)
        contenView.addSubview(leadPhTF)
        contenView.addSubview(totalTF)
        contenView.addSubview(totalLabel)
        contenView.addSubview(goToHomepageButton)
        callApi()
        totalTF.isUserInteractionEnabled = false
        leadTNameTF.isUserInteractionEnabled = false
        leadEmailTF.isUserInteractionEnabled = false
        leadPhTF.isUserInteractionEnabled = false
     
    }

    func callApi(){
        ApiManager.shared.hotelRedirect(key: key) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.view.stopLoading()
                    if model.code == "200" {
                        self.redirect = model
                        self.leadTNameTF.text = model.result[0].contact[0].fname
                        self.leadEmailTF.text = model.result[0].contact[0].email
                        self.leadPhTF.text = model.result[0].contact[0].phone
                        self.totalTF.text = model.result[0].totalPrice

                    }
                }
            case .failure(let error):
                self.view.stopLoading()
                print(error.localizedDescription)
            }
        }
 
    }
    
    @objc private func goToHomepageButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true)
    }

    func loadDetails(model : HotelRedirect){
       
    }
    @objc private func didTapBackButton(){
        dismiss(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            
            
            leadTHeadLabel.topAnchor.constraint(equalTo: contenView.safeAreaLayoutGuide.topAnchor, constant: 40),
            leadTHeadLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
            leadTHeadLabel.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -10),
            leadTHeadLabel.heightAnchor.constraint(equalToConstant: 15),
            
            
            
            leadTNameTF.topAnchor.constraint(equalTo: leadTHeadLabel.bottomAnchor, constant: 10),
            leadTNameTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
            leadTNameTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
            leadTNameTF.heightAnchor.constraint(equalToConstant: 50),
            
            leadEmailTF.topAnchor.constraint(equalTo: leadTNameTF.bottomAnchor, constant: 15),
            leadEmailTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
            leadEmailTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
            leadEmailTF.heightAnchor.constraint(equalToConstant: 50),
            
            leadPhTF.topAnchor.constraint(equalTo: leadEmailTF.bottomAnchor, constant: 15),
            leadPhTF.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
            leadPhTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
            leadPhTF.heightAnchor.constraint(equalToConstant: 50),
            
            
            totalTF.topAnchor.constraint(equalTo: leadPhTF.bottomAnchor, constant: 15),
            totalTF.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
            totalTF.widthAnchor.constraint(equalToConstant: 130),
            totalTF.heightAnchor.constraint(equalToConstant: 50),
            
            totalLabel.topAnchor.constraint(equalTo: leadPhTF.bottomAnchor, constant: 10),
            totalLabel.trailingAnchor.constraint(equalTo: totalTF.leadingAnchor, constant: 10),
            totalLabel.widthAnchor.constraint(equalToConstant: 100),
            totalLabel.heightAnchor.constraint(equalToConstant: 50),
       
            goToHomepageButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 290),
            goToHomepageButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 15),
            goToHomepageButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -15),
            goToHomepageButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
}



