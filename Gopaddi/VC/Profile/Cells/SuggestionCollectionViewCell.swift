//
//  SuggestionCollectionViewCell.swift
//  Gopaddi
//
//  Created by jizan k on 02/03/23.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var suggestionBtn: UIButton!
    var suggestion : (() -> ())?
    @IBAction func didTapSuggestion(_ sender: Any) {
        suggestion?()
    }
}
