//
//  MenuTabVC.swift
//  Gopaddi
//
//  Created by admin on 28/12/22.
//

import UIKit
import SDWebImage

class MenuTabVC: UIViewController {

    @IBOutlet weak var popUpBtn: UIButton!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var category: UITableViewCell!
    let utility = UtilitiesFunctions()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        popUpBtn.layer.cornerRadius = popUpBtn.frame.width/2
        let picture = UserDefaults.standard.string(forKey: "picture") ?? ""
        let name = UserDefaults.standard.string(forKey: "logname") ?? ""
        profileImage.sd_setImage(with: URL(string: picture))
        profileName.text = name
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    @IBAction func didTapPopUp(_ sender: Any) {
        
        
        

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopupVC") as? ProfilePopupVC
        self.present(vc!, animated: true)
        
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopupVC") as? ProfilePopupVC
//            vc?.modalPresentationStyle = .fullScreen
//            self.present(vc!, animated: true)
    }
    
}
extension MenuTabVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.iconView.image = menuPage[indexPath.row].icon.withTintColor(.label, renderingMode: .alwaysTemplate)
        cell.titleLbl.text = menuPage[indexPath.row].title
        let selectedBackgroundView = UIView()
         selectedBackgroundView.backgroundColor = UIColor.white // You can change this to any color you want
         cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1 :  let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        case 2 :let vc = BookingSelectionViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        case 6 : signOutBtnClicked()
        default : print("Inalid")
        }
        
        
    }
    func signOutBtnClicked() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure want to signOut?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { [self] _ in
           
            utility.isLogOut()
            utility.removeLogging()
            self.utility.saveLogging(false)
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
           
        }
        let cancel = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
}
