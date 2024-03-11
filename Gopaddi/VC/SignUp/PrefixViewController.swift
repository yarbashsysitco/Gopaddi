//
//  PrefixViewController.swift
//  Gopaddi
//
//  Created by jizan k on 07/03/24.
//

import UIKit

class PrefixViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        self.tableview.register(UINib(nibName: "prefixTableViewCell", bundle: .main), forCellReuseIdentifier: "prefixTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "prefixTableViewCell", for: indexPath)as! prefixTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
