//
//  FlightListTableCell.swift
//  Gopaddi
//
//  Created by admin on 01/11/23.
//

import UIKit

class FlightListTableCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cellMainView: UIView!
    @IBOutlet weak var coutryImage: UIImageView!
    @IBOutlet weak var flightNameLb: UILabel!
    @IBOutlet weak var flightCodeLb: UILabel!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var totalPriceLb: UILabel!
    
    @IBOutlet weak var oneWayDeparturTimeLb: UILabel!
    @IBOutlet weak var oneWayDeparturDateLb: UILabel!
    @IBOutlet weak var oneWayArrivalTimeLb: UILabel!
    @IBOutlet weak var oneWayArrivalDateLb: UILabel!
    @IBOutlet weak var oneWayTravelingTimeLb: UILabel!
    @IBOutlet weak var stopsLb: UILabel!
    
    @IBOutlet weak var returnDeparturTimeLb: UILabel!
    @IBOutlet weak var returnDeparturDateLb: UILabel!
    @IBOutlet weak var returnArrivalTimeLb: UILabel!
    @IBOutlet weak var returnArrivalDateLb: UILabel!
    @IBOutlet weak var returnTravelingTimeLb: UILabel!
    @IBOutlet weak var returnStopsLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        add3DEffect()
    }
    
    func add3DEffect() {
     
        cellMainView.layer.shadowOpacity = 0.1 // Adjust shadow opacity
        cellMainView.layer.shadowRadius = 10 // Adjust shadow radius for blur
        
        // You can continue to adjust other properties like cornerRadius, borderWidth, borderColor if needed
        cellMainView.layer.cornerRadius = 10
        cellMainView.layer.borderWidth = 1
        cellMainView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
