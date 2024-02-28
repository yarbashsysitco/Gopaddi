//
//  OnboardingCollectionViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 15/12/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnboardingCollectionViewCell"
    
   
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    func infoSetup(_ info : OnboardingData){
        slideTitleLbl.font = UIFont(name: "Poppins-Regular", size: 24)
        slideDescriptionLbl.font = UIFont(name: "Lora-Regular", size: 16)
        slideImageView.image = info.image
        slideTitleLbl.text = info.title
        slideDescriptionLbl.text = info.description
    }
}
