//
//  FromCalendarVC.swift
//  Gopaddi
//
//  Created by jizan k on 28/03/24.
//

import UIKit

protocol fromdate{
    func dates(date: String)
}
class FromCalendarVC: UIViewController {
    
    
    var sendDeligate: fromdate?
    var dateData = String()
    @IBOutlet weak var picker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.datePickerMode = .date
                picker.minimumDate = Date()
                picker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
    }
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func chooseBtn(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let selectedDate = picker.date
                let formattedDate = dateFormatter.string(from: selectedDate)
                dateData = (formattedDate)
                sendDeligate?.dates(date: dateData)
                self.dismiss(animated: true)
        
            }
    }
    



