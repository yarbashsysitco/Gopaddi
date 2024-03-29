//
//  AgeSelectionVC.swift
//  Gopaddi
//
//  Created by jizan k on 28/03/24.
//

import UIKit

protocol ageDataPass {
    func ages(ageData: [String])
}
class AgeSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ageDelegate: ageDataPass?
    var agetext = [String]()
    var ages = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var MainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MainView.layer.maskedCorners = [.layerMinXMinYCorner ,.layerMaxXMinYCorner]
        MainView.layer.cornerRadius = 12
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib.init(nibName: "AgeSelectionTBCell", bundle: nil),forCellReuseIdentifier: "AgeSelectionTBCell")
    }
    @IBAction func didTapCloseBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgeSelectionTBCell", for: indexPath)as! AgeSelectionTBCell
        cell.agelbl.text = ages[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        agetext.append(ages[indexPath.row])
        print(agetext)
        ageDelegate?.ages(ageData: agetext)
        self.dismiss(animated: true)
      }
    }

