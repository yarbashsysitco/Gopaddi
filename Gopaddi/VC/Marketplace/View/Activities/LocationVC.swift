//
//  LocationVC.swift
//  Gopaddi
//
//  Created by jizan k on 28/03/24.
//

import UIKit

class LocationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var locationTxt: FormTextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "LocationVCTBCell", bundle: nil),forCellReuseIdentifier: "LocationVCTBCell")
        locationTxt.setPadding(16)
        
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationVCTBCell", for: indexPath)as! LocationVCTBCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }



}
