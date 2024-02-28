//
//  SettingsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 12/01/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var userId : String?
    var deletion : DeleteModel?
    let apiManager = ApiManager()
   var utility = UtilitiesFunctions()
   override func viewDidLoad() {
        super.viewDidLoad()
       tableView.delegate = self
       tableView.dataSource = self
       
    }
func signOutBtnClicked() {
    let alert = UIAlertController(title: "Sign Out", message: "Are you sure want to signOut?", preferredStyle: .alert)
    let action = UIAlertAction(title: "Yes", style: .default) { [self] _ in
        userId = UserDefaults.standard.string(forKey: GlobalConstants.userLoginKeys.key)
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
    
     func personalBtnClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileInfoViewController") as! ProfileInfoViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
 func deleteBtnClicked(){
        let alert = UIAlertController(title: "Account Deletion", message: "Are you sure want to Delete Account?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { [self] _ in
            let userId = UserDefaults.standard.string(forKey: "gkey") ?? (UserDefaults.standard.string(forKey: "logkey") ?? UserDefaults.standard.string(forKey: GlobalConstants.userLoginKeys.key))
            self.tableView.showLoading()
            self.apiManager.deleteAccount(user: userId!) { result in
                switch result {
                case.success(let model):
                    self.deletion = model
                    DispatchQueue.main.async {
                        if model.code == "200" {
                            self.tableView.stopLoading()
                            let alert = UIAlertController(title: "Done!", message:model.message , preferredStyle: .alert)
                            let alertButoon = UIAlertAction(title: "Ok", style: .default) { _ in
                                let vc = SignInVC()
                                vc.modalPresentationStyle = .fullScreen
                                vc.modalTransitionStyle = .flipHorizontal
                                self.present(vc, animated: true)
                            }
                            alert.addAction(alertButoon)
                            self.present(alert, animated: false)
                        }
                        else {
                            self.tableView.stopLoading()
                            let alert = UIAlertController(title: "Error", message: model.message.debugDescription, preferredStyle: .alert)
                            let action = UIAlertAction(title: "Ok", style: .cancel)
                            alert.addAction(action)
                            self.present(alert, animated: false)
                        }
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                    self.tableView.stopLoading()
                }
            }
            self.utility.saveLogging(false)
            self.utility.isLogOut()
            self.utility.removeLogging()
        }
        let cancel = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        }
}
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsHead.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.setup(with: settingsHead[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0 : print("Persoanl")
            personalBtnClicked()
        case 1 : print("Terms")
        case 2 : print("Security")
        case 3 : print("Delete")
            deleteBtnClicked()
        case 4 : print("SignOut")
            signOutBtnClicked()
        default : print("Out of bound")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
