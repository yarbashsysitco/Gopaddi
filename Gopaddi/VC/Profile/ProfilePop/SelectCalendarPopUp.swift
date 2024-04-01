//
//  SelectCalendarPopUp.swift
//  Gopaddi
//
//  Created by admin on 29/02/24.
//

import UIKit


protocol date{
    func dates(date: String)
}
class SelectCalendarPopUp: UIViewController {
   
    @IBOutlet weak var cencelBtn: UIButton!
    
    var dateDeligate: date?
    var dateData = String()
    @IBOutlet weak var picker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        cencelBtn.layer.cornerRadius = 5
        picker.datePickerMode = .date
                picker.minimumDate = Date()
                picker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
    }
    
    
    @IBAction func cencelBtnss(_ sender: Any) {
        self.dismiss(animated: true)
    }
   
    @IBAction func CooseDateButton(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let selectedDate = picker.date
                let formattedDate = dateFormatter.string(from: selectedDate)
                dateData = (formattedDate)
                dateDeligate?.dates(date: dateData)
                self.dismiss(animated: true)
        
            }
    }

