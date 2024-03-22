//
//  OtpViewController.swift
//  Gopaddi
//
//  Created by jizan k on 05/01/23.
//

import UIKit

class OtpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var fourthOtpTF: UITextField!
    @IBOutlet weak var thirdOtpTF: UITextField!
    @IBOutlet weak var secondOtpTF: UITextField!
    @IBOutlet weak var firstOtpTF: UITextField!
    var otpText = String()
    var signUpEmail = String()
    var userKey = String()
    var register : Register?
    var countDown = 60
    var otpModel: OtpModel?
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // configView()
                firstOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
                secondOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
                thirdOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
                fourthOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        firstOtpTF.becomeFirstResponder()
        //        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(chacgeResetButton), userInfo: nil, repeats: true)
        
        firstOtpTF.delegate = self
        firstOtpTF.keyboardType = .numberPad
        secondOtpTF.delegate = self
        secondOtpTF.keyboardType = .numberPad
        thirdOtpTF.delegate = self
        thirdOtpTF.keyboardType = .numberPad
        fourthOtpTF.delegate = self
        fourthOtpTF.keyboardType = .numberPad
    }
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func configView(){
        self.view.backgroundColor = .clear
        //        self.view.backgroundColor   = .black.withAlphaComponent(0.6)
        self.view.alpha = 1
        self.contentView.alpha = 2
        self.contentView.layer.cornerRadius = 10
    }
    @objc private func chacgeResetButton() {
        countDown -= 1
        timerLbl.text = "0:\(countDown)"
        if countDown == 0 {
            resendBtn.setTitleColor(UIColor.blue, for: .normal)
            resendBtn.isEnabled = true
            timer?.invalidate()
        }
    }
        @objc func textFieldDidChange(textField: UITextField){
              let text = textField.text
              if  text?.count == 1 {
                  switch textField{
                  case firstOtpTF:
                      secondOtpTF.becomeFirstResponder()
                  case secondOtpTF:
                      thirdOtpTF.becomeFirstResponder()
                  case thirdOtpTF:
                      fourthOtpTF.becomeFirstResponder()
                  case fourthOtpTF:
                      fourthOtpTF.resignFirstResponder()
//                       let keyText = signUpEmail
//                      let memberText = "gopal"
//                     let otpText = "\(self.firstOtpTF.text ?? "")\(self.secondOtpTF.text ?? "")\(self.thirdOtpTF.text ?? "")\(self.fourthOtpTF.text ?? "")"
//                      UserDefaults.standard.set(keyText, forKey: "otpemail")
//                      UserDefaults.standard.set(otpText, forKey: "otpkey")
//                      ApiManager.shared.callOtpTest(otp: otpText, email: keyText, membership: memberText) { result in
//                           switch result {
//                           case.success(let model):
//                               self.otpModel = model
//                               if model.code == "200" {
//                                   let alertController = UIAlertController(title:"Success!", message: model.message, preferredStyle: .alert)
//                                   let button = UIAlertAction(title: "Ok", style: .default) { _ in
//                                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
//                                       vc.modalPresentationStyle = .fullScreen
//                                       self.present(vc, animated: true)
//    //                                   vc.userNameTF.text = keyText
//                                   }
//                                   alertController.addAction(button)
//                                   self.present(alertController, animated: true)
//                               }else {
//                                   let alert = UIAlertController(title: "Error!", message: model.message, preferredStyle: .alert)
//                                   let alertButton = UIAlertAction(title: "Ok", style: .cancel)
//                                   alert.addAction(alertButton)
//                                   self.present(alert, animated: false)
//                               }
//                           case.failure(let error):
//                               print(error.localizedDescription)
//                               print("error qaqa")
//                           }
//                       }
//                  default:
//                      break
                  default:
                      break
                  }
              }
              if  text?.count == 0 {
                  switch textField{
                  case firstOtpTF:
                      firstOtpTF.becomeFirstResponder()
                  case secondOtpTF:
                      firstOtpTF.becomeFirstResponder()
                  case thirdOtpTF:
                      secondOtpTF.becomeFirstResponder()
                  case fourthOtpTF:
                      thirdOtpTF.becomeFirstResponder()
                  default:
               break
                  }
              }
            func dismissKeyboard(){
                   self.otpText = "\(self.firstOtpTF.text ?? "")\(self.secondOtpTF.text ?? "")\(self.thirdOtpTF.text ?? "")\(self.fourthOtpTF.text ?? "")"
                   print(self.otpText)
                   self.view.endEditing(true)
               }
          }
    @IBAction func resendBtnClicked(_ sender: Any) {
        ApiManager.shared.resendOTP(email: signUpEmail) { result in
            switch result {
            case.success(let model):
                self.otpModel = model
                let alercontroller = UIAlertController(title: "Success!", message: model.message, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel)
                alercontroller.addAction(action)
                self.present(alercontroller, animated: true)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func submitBtn(_ sender: Any) {
        let keyText = signUpEmail
        let memberText = "gopal"
        let otpText = "\(self.firstOtpTF.text ?? "")\(self.secondOtpTF.text ?? "")\(self.thirdOtpTF.text ?? "")\(self.fourthOtpTF.text ?? "")"
        UserDefaults.standard.set(keyText, forKey: "otpemail")
        UserDefaults.standard.set(otpText, forKey: "otpkey")
        ApiManager.shared.callOtpTest(otp: otpText, email: keyText, membership: memberText) { result in
            switch result {
            case.success(let model):
                self.otpModel = model
                if model.code == "200" {
                    let alertController = UIAlertController(title:"Success!", message: model.message, preferredStyle: .alert)
                    let button = UIAlertAction(title: "Ok", style: .default) { _ in
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                        //                                   vc.userNameTF.text = keyText
                    }
                    alertController.addAction(button)
                    self.present(alertController, animated: true)
                }else {
                    let alert = UIAlertController(title: "Error!", message: model.message, preferredStyle: .alert)
                    let alertButton = UIAlertAction(title: "Ok", style: .cancel)
                    alert.addAction(alertButton)
                    self.present(alert, animated: false)
                }
            case.failure(let error):
                print(error.localizedDescription)
                print("error qaqa")
            }
            
            
        }
        
        
        
    }
}
