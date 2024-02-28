//
//  ProfileInfoVC.swift
//  Gopaddi
//
//  Created by admin on 28/02/24.
//

import UIKit

class ProfileInfoVC: UIViewController {

    @IBOutlet weak var BirthView: UIView!
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var BioView: UIView!
    @IBOutlet weak var NameView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        borders(view: BirthView, color: .lightGray, width: 2, radius: 5)
        borders(view: LocationView, color: .lightGray, width: 2, radius: 5)
        borders(view: BioView, color: .lightGray, width: 2, radius: 5)
        borders(view: NameView, color: .lightGray, width: 2, radius: 5)

        
    }
    func borders(view: UIView,color: UIColor, width: CGFloat, radius: CGFloat){
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
        view.layer.cornerRadius = radius
    }

}
