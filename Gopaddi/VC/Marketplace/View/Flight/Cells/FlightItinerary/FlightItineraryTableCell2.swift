//
//  FlightItineraryTableCell2.swift
//  Gopaddi
//
//  Created by admin on 10/11/23.
//

import UIKit

class FlightItineraryTableCell2: UITableViewCell {

    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    
    @IBOutlet weak var flyDerpatureplace1: UILabel!
    @IBOutlet weak var flyDerpaturAircodeCabin3: UILabel!
    
    @IBOutlet weak var flyArrivalplace1: UILabel!
    @IBOutlet weak var flyArrivalAircodeCabin3: UILabel!
    
    @IBOutlet weak var flycodeTimeDepatur2: UILabel!
    @IBOutlet weak var flycodeTimeArrivel2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editViews()
    }
    func applyStyles(to view: UIView) {
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
    }
    func editViews() {
        applyStyles(to: View1)
        applyStyles(to: View2)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
