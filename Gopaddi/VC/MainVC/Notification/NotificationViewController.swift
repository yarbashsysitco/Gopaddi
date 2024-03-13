//
//  NotificationViewController.swift
//  Gopaddi
//
//  Created by jizan k on 12/03/24.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var systemBtn: UIButton!
    @IBOutlet weak var activityBtn: UIButton!
    @IBOutlet weak var socialBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var table: UITableView!
    var btnTag = "0"
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        table.register(UINib.init(nibName: "NotificationAllTBCell", bundle: nil), forCellReuseIdentifier: "NotificationAllTBCell")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "NotificationAllTBCell", for: indexPath)as! NotificationAllTBCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 234
        
    }

    @IBAction func NotificationBtnClick(_ sender: UIButton) {
        switch sender.tag {
            case 0:
                allBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
                socialBtn.backgroundColor = .clear
                activityBtn.backgroundColor = .clear
                systemBtn.backgroundColor = .clear
                self.btnTag = "0"
            case 1:
                allBtn.backgroundColor = .clear
                socialBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
                activityBtn.backgroundColor = .clear
                systemBtn.backgroundColor = .clear
                self.btnTag = "1"
            case 2:
                allBtn.backgroundColor = .clear
                socialBtn.backgroundColor = .clear
                activityBtn.backgroundColor  =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
                activityBtn.backgroundColor  =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
                systemBtn.backgroundColor = .clear
                self.btnTag = "2"
            default:
                allBtn.backgroundColor = .clear
                socialBtn.backgroundColor = .clear
                activityBtn.backgroundColor = .clear
                systemBtn.backgroundColor  =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
                self.btnTag = "3"
        }

        
       }

}
