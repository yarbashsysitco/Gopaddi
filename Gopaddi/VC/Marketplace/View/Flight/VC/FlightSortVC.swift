//
//  FlightSortVC.swift
//  Gopaddi
//
//  Created by admin on 07/11/23.
//

import UIKit

class FlightSortVC: UIViewController {
 
    let priceSection = "Sort By"
    let priceText = ["Price(Low to High)","Price(High to Low)"]
    var sortValue : Int = 0
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var HighPriceBtn: UIButton!
    @IBOutlet weak var LowPriceBtn: UIButton!
    var FlightListSVC : FlightListVC?
    var sortTag = 0
    var delegate : Flightsort?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
     }
    
    func configView(){
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        self.contentView.alpha = 2
        self.contentView.layer.cornerRadius = 10
    }
    func appear(sender : UIViewController){
        sender.present(self, animated: false)
        self.show()
    }
    func show(){
        UIView.animate(withDuration: 1, delay: 0.1){
            
        }
    }
    func hide(){
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut){
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion:{_ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    @IBAction func HighPriceBtn(_ sender: Any) {
        var tagValue = 1
        delegate?.sortDetails(sortValue: tagValue)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func LowPriceBtn(_ sender: Any) {
        var tagValue  = 2
        delegate?.sortDetails(sortValue: tagValue)
        dismiss(animated: true, completion: nil)
    }
}
