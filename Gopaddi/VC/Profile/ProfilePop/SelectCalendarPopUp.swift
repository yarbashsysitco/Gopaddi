//
//  SelectCalendarPopUp.swift
//  Gopaddi
//
//  Created by admin on 29/02/24.
//

import UIKit

class SelectCalendarPopUp: UIViewController {
    @IBOutlet weak var cencelBtn: UIButton!
    
    @IBOutlet weak var picker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        cencelBtn.layer.cornerRadius = 5
        
    }
    
    @IBAction func cencelBtnss(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
   
    @IBAction func CooseDateButton(_ sender: UIButton) {
        
    }
    

}
