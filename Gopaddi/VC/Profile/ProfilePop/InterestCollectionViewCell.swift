//
//  InterestCollectionViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 24/01/23.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imaageView: UIImageView!
    func setUp(with interest : InterestData){
        imaageView.image = interest.image.withRenderingMode(.alwaysTemplate)
        labelView.text = interest.title
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
      
    }
}
