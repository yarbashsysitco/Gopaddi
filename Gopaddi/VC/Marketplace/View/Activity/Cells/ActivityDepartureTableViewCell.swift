//
//  ActivityDepartureTableViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 30/04/23.
//

import UIKit
class ActivityDepartureTableViewCell: UITableViewCell {
    var isChecked: Bool = false
    var bookClicked : (() -> ())?
    static let identifier = "ActivityDepartureTableViewCell"
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(headerView)
        headerView.addSubview(contentLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            contentLabel.topAnchor.constraint(equalTo:headerView.topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
        ])
    }
    func configure(content: String) {
        contentLabel.text = content
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
