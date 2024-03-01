//
//  SelectCalendarPopUp.swift
//  Gopaddi
//
//  Created by admin on 29/02/24.
//

import UIKit

class SelectCalendarPopUp: UIViewController {
    @IBOutlet weak var cencelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cencelBtn.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cencelBtnss(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
   
   

}
