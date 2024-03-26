//
//  GopaddiAccountsVC.swift
//  Gopaddisubdemo
//
//  Created by Apple on 20/03/24.
//

import UIKit

class GopaddiAccountsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var accountType = ["GoPal","GoFamily","GoBusiness","GoSchool"]
    var Counts: Int = -1
    var isSelected = false
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.tableview.register(UINib.init(nibName: "GopaddiAccountsTBCell", bundle: nil), forCellReuseIdentifier: "GopaddiAccountsTBCell")
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GopaddiAccountsTBCell", for: indexPath) as! GopaddiAccountsTBCell
        cell.accountDescription.text = "your one-stop shop for unforgettable travel experience"
        cell.accountName.text = accountType[indexPath.row]
        cell.accountImages.image = UIImage(named: accountType[indexPath.row])

        if Counts == indexPath.row {
            cell.AccountView.layer.borderColor = UIColor.systemBlue.cgColor
            cell.radioBtnImage.image = UIImage(named: "BlueRadioButton")
        } else {
            cell.AccountView.layer.borderColor = UIColor.systemGray5.cgColor
            cell.radioBtnImage.image = UIImage(named: "RadioButton")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Counts = indexPath.row
           print("Selected row: \(Counts)")
           tableview.reloadData()

           if Counts != -1 {
               continueBtn.backgroundColor = .systemBlue
           } else {
               continueBtn.backgroundColor = .systemGray5
           }
    }

    
    @IBAction func continueBtnClick(_ sender: UIButton) {
        let vc = UIStoryboard(name: "OnboardingAccountMain", bundle: nil).instantiateViewController(withIdentifier: "ContainersGopaddiVC")as! ContainersGopaddiVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
