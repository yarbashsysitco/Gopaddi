//
//  PrefixViewController.swift
//  Gopaddi
//
//  Created by jizan k on 06/02/23.
//

import UIKit

class PrefixTableViewCell: UITableViewCell {
    static let identifier = "PrefixTableViewCell"

    public let keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public let countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(keyLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countryImageView)

        NSLayoutConstraint.activate([
            keyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            keyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: self.keyLabel.trailingAnchor, constant: 10),
            
            countryImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 28),
            countryImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            countryImageView.widthAnchor.constraint(equalToConstant: 35),
            countryImageView.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(key: String, title: String) {
        self.keyLabel.text = key
        self.titleLabel.text = title
    }
}
extension PrefixTableViewCell {
//    var interactor:Interactor?
    
    @IBAction func close(_ sender: UIButton) {
        
//       dismiss(animated: true, completion: nil)
    }
    func showHelperCircle(){
        let center = CGPoint(x: contentView.bounds.width * 0.5, y: 100)
        let small = CGSize(width: 30, height: 30)
        let circle = UIView(frame: CGRect(origin: center, size: small))
        circle.layer.cornerRadius = circle.frame.width/2
        circle.backgroundColor = UIColor.white
        circle.layer.shadowOpacity = 0.8
        circle.layer.shadowOffset = CGSize()
        contentView.addSubview(circle)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [],
            animations: {
                circle.frame.origin.y += 200
                circle.layer.opacity = 0
            },
            completion: { _ in
                circle.removeFromSuperview()
            }
        )
    }

//    override func viewDidAppear(_ animated: Bool) {
//        showHelperCircle()
//    }
}
    
