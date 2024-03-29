//
//  ProfileInfoVC.swift
//  Gopaddi
//
//  Created by admin on 28/02/24.
//

import UIKit

class ProfileInfoVC: UIViewController ,SendingData{
    func SaveData(Title: String, Image: UIImage?) {
        whouseBtn.setTitle(Title, for: .normal)
        whouseBtn.setImage(Image, for: .normal)
    }
    

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var whouseBtn: UIButton!
    @IBOutlet weak var BirthView: UIView!
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var BioView: UIView!
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    
    @IBOutlet weak var FnameTF: UITextField!
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var bioTF: UITextView!
    @IBOutlet weak var locationTF: UITextField!
    var EditProfil : EditProfileModel?
    
    var Btntitles = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        borders(view: BirthView, color: .lightGray, width: 2, radius: 5)
        borders(view: LocationView, color: .lightGray, width: 2, radius: 5)
        borders(view: BioView, color: .lightGray, width: 2, radius: 5)
        borders(view: NameView, color: .lightGray, width: 2, radius: 5)
   borders(view: lastNameView, color: .lightGray, width: 2, radius: 5)
        bioTF.delegate = self
        bioTF.text = "Tap to add bio"
        bioTF.textColor = UIColor.lightGray
        
    }
    func borders(view: UIView,color: UIColor, width: CGFloat, radius: CGFloat){
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
        view.layer.cornerRadius = radius
    }
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func interestButtonsTap(_ sender: UIButton) {
        guard let Buttons = sender as UIButton? else{return}
        if let Btntaps = sender.titleLabel?.text{
            if !sender.isSelected{
                Buttons.layer.backgroundColor = UIColor.white.cgColor
                Btntitles.append(Btntaps)
                print(Btntitles)
            }else{
                if let index = Btntitles.firstIndex(of: Btntaps){
                    Btntitles.remove(at: index)
                    print(Btntitles)
                }
            }
            
        }
        if !Buttons.isSelected{
            Buttons.isSelected = true
            Buttons.layer.backgroundColor  =    #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            Buttons.layer.cornerRadius = 25
            Buttons.tintColor = UIColor.white
            
            
        }else{
            Buttons.isSelected = false
            Buttons.layer.backgroundColor =   #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            Buttons.titleLabel?.textColor
            Buttons.layer.cornerRadius = 25
            Buttons.tintColor = UIColor.black
        }
        
    }
    
    @IBAction func birthdayBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectCalendarPopUp") as? SelectCalendarPopUp
        //vc?.modalPresentationStyle = .fullScreen
        print("hello")
        self.present(vc!, animated: true)
    }
    
    @IBAction func whocanTapButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WhocanSeeProfileViewController") as! WhocanSeeProfileViewController
        vc.sendDeligate = self
        self.present(vc, animated: true)
    }
    
    
    
    @IBAction func saveBtn(_ sender: Any) {
        
        self.saveBtn.showLoading()
          guard let userFname = FnameTF.text, !userFname.isEmpty else {
              self.saveBtn.stopLoading()
              showAlert(message: "Please enter your first name", duration: 2.0)
              return
          }

          guard let userlName = lNameTF.text, !userlName.isEmpty else {
              self.saveBtn.stopLoading()
              showAlert(message: "Please enter your last name", duration: 2.0)
              return
          }
          
          // Retrieve user email from UserDefaults
          guard let userEmail = UserDefaults.standard.string(forKey: "logemail") else {
              self.saveBtn.stopLoading()
              showAlert(message: "User email not found", duration: 2.0)
              return
          }
          
          // Retrieve user phone number from UserDefaults
          guard let userPhone = UserDefaults.standard.string(forKey: "logphone") else {
              self.saveBtn.stopLoading()
              showAlert(message: "User phone number not found", duration: 2.0)
              return
          }
          
          // Retrieve user ID from UserDefaults
          guard let userId = UserDefaults.standard.string(forKey: "userid") else {
              self.saveBtn.stopLoading()
              showAlert(message: "User ID not found", duration: 2.0)
              return
          }

        guard let userFname = FnameTF.text else { return }
        guard let userlName = lNameTF.text else { return }
//        validateFields()//        if isValidUser , isValidPass {
        UserDefaults.standard.set(userFname, forKey: "userFname")
        UserDefaults.standard.set(userlName, forKey: "userlName")
        ApiManager.shared.userEditProfile(fname: userFname, lname: userlName, email: userEmail, phone: userPhone, userId: userId) { result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async { [weak self] in
//                    self?.registered = true
                    self?.EditProfil = model
                    if model.code == "200" {
                        self?.saveBtn.stopLoading()
                        let alert = UIAlertController(title: "Message", message: model.message.debugDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                            self?.dismiss(animated: true)
                        }
                        alert.addAction(action)
                        self?.present(alert, animated: true)
                        print(model.message)
    
                    } else if  model.code == "404"  {
                        self?.saveBtn.stopLoading()
                        self?.showAlert(message: "Error!", duration: 2.0)
                    } else if  model.code == "500"  {
                        self?.showAlert(message: "Error!", duration: 2.0)
                    }
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    self.saveBtn.stopLoading()
                    self.showAlert(message: "Error!", duration: 2.0)
                }
            }
        }
        
        
        
    }
    
}
extension ProfileInfoVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Tap to add bio"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
