//
//  ActivityFilterViewController.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit
import RangeSeekSlider
class ActivityFilterViewController: UIViewController {
    
    var delegate : FilterInfo?
    var price : String = " "
    var filterDuration : [String]?
    var value : Int?
    var priceR : String?
    var minPrice = CGFloat()
    var maxPrice = CGFloat()
    var checkTag: String = "1-2"
    var selectedIndex : Int?
    private let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let outerView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let orderView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let checkButtonDesc: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let checkButtonAsc: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let ascLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "1 - 2"
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "3 - 60"
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let ApplyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 18)
        return button
    }()
    private let priceRange: UILabel = {
        let label = UILabel()
        label.text = "Price Range"
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let orderNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of days"
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let titleLAbel: UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let rangeSeekSlider = RangeSeekSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        rangeSeekSlider.lineHeight = 3
        view.addSubview(outerView)
        outerView.addSubview(contentView)
        contentView.addSubview(titleLAbel)
        contentView.addSubview(closeButton)
        contentView.addSubview(rangeSeekSlider)
        contentView.addSubview(priceRange)
        contentView.addSubview(orderView)
        orderView.addSubview(orderNameLabel)
        orderView.addSubview(ascLabel)
        orderView.addSubview(descLabel)
        orderView.addSubview(checkButtonAsc)
        orderView.addSubview(checkButtonDesc)
        contentView.addSubview(ApplyButton)
        rangeSeekSlider.frame = CGRectMake(0, 0, view.frame.width-20, 50)
        rangeSeekSlider.maxValue = maxPrice
        rangeSeekSlider.minValue = minPrice
        rangeSeekSlider.translatesAutoresizingMaskIntoConstraints = false
        ApplyButton.addTarget(self, action: #selector(didTapApply), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        checkButtonAsc.addTarget(self, action: #selector(didTapCheck), for: .touchUpInside)
        checkButtonDesc.addTarget(self, action: #selector(didTapCheck), for: .touchUpInside)
        
    }
    @objc func didTapClose(){
        self.dismiss(animated: true)
    }
    @objc func didTapApply(){
        let selectedMinValue = self.rangeSeekSlider.selectedMinValue
        var selectedMaxValue = self.rangeSeekSlider.selectedMaxValue
        if selectedMaxValue == 100 {
            selectedMaxValue = maxPrice
        }
        self.price = String(selectedMinValue.description) + "-" + String(selectedMaxValue.description)
        filterDuration = [checkTag]
        self.delegate?.filterDetails(prRange: self.price, duration: self.filterDuration ?? [])
        print("filterDuration\(String(describing: self.filterDuration))")
        self.dismiss(animated: true)
    }
    @objc func didTapCheck(sender : UIButton){
        if sender.tag == 1{
            checkTag = "1-2"
            checkButtonAsc.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            checkButtonDesc.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        else {
            checkTag = "3-60"
            checkButtonAsc.setImage(UIImage(systemName: "circle"), for: .normal)
            checkButtonDesc.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            outerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            outerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            outerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            outerView.heightAnchor.constraint(equalToConstant: 410),
            
            contentView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor,constant: 10),
            contentView.trailingAnchor.constraint(equalTo: outerView.trailingAnchor,constant: -10),
            contentView.topAnchor.constraint(equalTo: outerView.topAnchor,constant: 10),
            
            titleLAbel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLAbel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLAbel.heightAnchor.constraint(equalToConstant: 45),
            
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            
            priceRange.topAnchor.constraint(equalTo: titleLAbel.bottomAnchor, constant: 10),
            priceRange.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            rangeSeekSlider.topAnchor.constraint(equalTo: priceRange.bottomAnchor, constant: 5),
            rangeSeekSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rangeSeekSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rangeSeekSlider.heightAnchor.constraint(equalToConstant: 50),
            
            orderView.topAnchor.constraint(equalTo: rangeSeekSlider.bottomAnchor, constant: 5),
            orderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            orderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            orderView.heightAnchor.constraint(equalToConstant: 150),
            
            orderNameLabel.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 20),
            orderNameLabel.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 20),
            
            ascLabel.topAnchor.constraint(equalTo: orderNameLabel.bottomAnchor, constant: 20),
            ascLabel.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 25),
            ascLabel.heightAnchor.constraint(equalToConstant: 20),
            
            checkButtonAsc.topAnchor.constraint(equalTo: orderNameLabel.bottomAnchor, constant: 20),
            checkButtonAsc.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -30),
            checkButtonAsc.heightAnchor.constraint(equalToConstant: 20),
            checkButtonAsc.widthAnchor.constraint(equalToConstant: 20),
            
            descLabel.topAnchor.constraint(equalTo: ascLabel.bottomAnchor, constant: 20),
            descLabel.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 25),
            descLabel.heightAnchor.constraint(equalToConstant: 20),
            
            checkButtonDesc.topAnchor.constraint(equalTo: checkButtonAsc.bottomAnchor, constant: 20),
            checkButtonDesc.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -30),
            checkButtonDesc.heightAnchor.constraint(equalToConstant: 20),
            checkButtonDesc.widthAnchor.constraint(equalToConstant: 20),
            
            ApplyButton.topAnchor.constraint(equalTo: orderView.bottomAnchor, constant: 5),
            ApplyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ApplyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ApplyButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}
