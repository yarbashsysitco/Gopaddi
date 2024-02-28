//
//  FlightItineraryTableCell.swift
//  Gopaddi
//
//  Created by admin on 08/11/23.
//

import UIKit

class FlightItineraryTableCell: UITableViewCell {

    
    
    @IBOutlet weak var CellView1: UIView!
    @IBOutlet weak var cellView2: UIView!
    
    @IBOutlet weak var flyltineryDerpatureplace1: UILabel!
    @IBOutlet weak var flyltineryDerpatureDateTime2: UILabel!
    @IBOutlet weak var flyltineryDerpaturAircodeCabin3: UILabel!
    
    @IBOutlet weak var flyltineryArrivalplace1: UILabel!
    @IBOutlet weak var flyltineryArrivalDateTime2: UILabel!
    @IBOutlet weak var flyltineryArrivalAircodeCabin3: UILabel!
    
    @IBOutlet weak var flycodeTimeDepatur: UILabel!
    
    @IBOutlet weak var flycodeTimeArrivel: UILabel!
    
    
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
       
        applyStyles(to: CellView1)
        applyStyles(to: cellView2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
