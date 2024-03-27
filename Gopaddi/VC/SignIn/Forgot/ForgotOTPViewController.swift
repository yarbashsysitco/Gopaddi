
//
//  ForgotOTPViewController.swift
//  Gopaddi
//
//  Created by jizan k on 07/03/24.
//

import UIKit
import Alamofire

class ForgotOTPViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailviewLb: UILabel!
    var emailview = String()
    @IBOutlet weak var resendBtn: UIButton!
    
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var fifthOtpTF: UITextField! // New UITextField added
    
    @IBOutlet weak var subBtn: UIButton!
    @IBOutlet weak var fourthOtpTF: UITextField!
    @IBOutlet weak var thirdOtpTF: UITextField!
    @IBOutlet weak var secondOtpTF: UITextField!
    @IBOutlet weak var firstOtpTF: UITextField!
    var forgotModel : ForgotPassword?

    var otpText = String()
    var signUpEmail = String()
    var userKey = String()
    var countDown = 60
    var otpModel: UserTokenModel?
    var timer: Timer?
    var isClicked : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        emailviewLb.text = emailview
        firstOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        secondOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        thirdOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        fourthOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        fifthOtpTF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged) // Add target for fifthOtpTF
        firstOtpTF.becomeFirstResponder()
        firstOtpTF.delegate = self
        firstOtpTF.keyboardType = .numberPad
        secondOtpTF.delegate = self
        secondOtpTF.keyboardType = .numberPad
        thirdOtpTF.delegate = self
        thirdOtpTF.keyboardType = .numberPad
        fourthOtpTF.delegate = self
        fourthOtpTF.keyboardType = .numberPad
        fifthOtpTF.delegate = self // Set delegate for fifthOtpTF
        fifthOtpTF.keyboardType = .numberPad // Set keyboard type for fifthOtpTF
        eyeBtn.setImage(UIImage(named: "openeye"), for: .normal)
        subBtn.isEnabled = false
    }
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
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
                  fifthOtpTF.becomeFirstResponder()
              case fourthOtpTF:
                  fourthOtpTF.resignFirstResponder()
                 
              default:
                  break
              }
            }
        if let text = text, text.isEmpty {
            switch textField {
            case secondOtpTF:
                firstOtpTF.becomeFirstResponder()
            case thirdOtpTF:
                secondOtpTF.becomeFirstResponder()
            case fourthOtpTF:
                thirdOtpTF.becomeFirstResponder()
            case fifthOtpTF:
                fourthOtpTF.becomeFirstResponder()
            default:
                break
            }
        }
        
//        // Automatically fill OTP if all text fields are filled
//        if let firstText = firstOtpTF.text, !firstText.isEmpty,
//           let secondText = secondOtpTF.text, !secondText.isEmpty,
//           let thirdText = thirdOtpTF.text, !thirdText.isEmpty,
//           let fourthText = fourthOtpTF.text, !fourthText.isEmpty,
//           let fifthText = fifthOtpTF.text, !fifthText.isEmpty {
//            let otp = firstText + secondText + thirdText + fourthText + fifthText
//            // Use the OTP for further processing, e.g., verification
//            print("OTP entered: \(otp)")
//            // Optionally, you can resignFirstResponder of the last text field after OTP is filled
//            fifthOtpTF.resignFirstResponder()
//        }

        func dismissKeyboard(){
               self.otpText = "\(self.firstOtpTF.text ?? "")\(self.secondOtpTF.text ?? "")\(self.thirdOtpTF.text ?? "")\(self.fourthOtpTF.text ?? "")\(self.fifthOtpTF.text ?? "")"
               print(self.otpText)
               self.view.endEditing(true)
           }
    }
    
    
    @IBAction func number1TF(_ sender: Any) {
        guard let firstOtp = firstOtpTF.text
        else {
            // If unable to get email or password, do nothing
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !firstOtp.isEmpty{
            subBtn.isEnabled = true
            subBtn.alpha = 1.0
            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            firstOtpTF.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
        
        } else {
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            firstOtpTF.layer.borderColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        }
        
    }
    
    @IBAction func number2TF(_ sender: Any) {
        guard let secondOtp = secondOtpTF.text
        else {
            // If unable to get email or password, do nothing
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !secondOtp.isEmpty{
            subBtn.isEnabled = true
            subBtn.alpha = 1.0
            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            secondOtpTF.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
        
        } else {
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            secondOtpTF.layer.borderColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        }
    }
    @IBAction func number3TF(_ sender: Any) {
        guard let thirdOtp = thirdOtpTF.text
        else {
            // If unable to get email or password, do nothing
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !thirdOtp.isEmpty{
            subBtn.isEnabled = true
            subBtn.alpha = 1.0
            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            thirdOtpTF.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
        
        } else {
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            thirdOtpTF.layer.borderColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        }
    }
    
    @IBAction func number4TF(_ sender: Any) {
        guard let fourthOtp = fourthOtpTF.text
        else {
            // If unable to get email or password, do nothing
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !fourthOtp.isEmpty{
            subBtn.isEnabled = true
            subBtn.alpha = 1.0
            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            fourthOtpTF.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
        
        } else {
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            fourthOtpTF.layer.borderColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        }
    }
    
    @IBAction func number5TF(_ sender: Any) {
        guard let fifthOtp = fifthOtpTF.text
        else {
            // If unable to get email or password, do nothing
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !fifthOtp.isEmpty{
            subBtn.isEnabled = true
            subBtn.alpha = 1.0
            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            fifthOtpTF.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
        
        } else {
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            fifthOtpTF.layer.borderColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        }
    }
    
    
    
    
//    @IBAction func fifthOtpEditingChanged(_ sender: UITextField) {
//
//        if firstOtpTF.text?.isEmpty == true {
//            firstOtpTF.layer.borderColor = UIColor.gray.cgColor
//            } else {
//                firstOtpTF.layer.borderColor = UIColor.green.cgColor
//            }
//
////
////        if sender.tag == 0{
////            firstOtpTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
////        }else{
////            firstOtpTF.layer.borderColor =  #colorLiteral(red: 0.3852982521, green: 0.3852982521, blue: 0.3852982521, alpha: 1)
////            subBtn.isEnabled = true
////            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
////            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
////        }
////
//        if firstOtpTF.text != nil{
//            firstOtpTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
//        }else{
//            firstOtpTF.layer.borderColor =  #colorLiteral(red: 0.3852982521, green: 0.3852982521, blue: 0.3852982521, alpha: 1)
//        }
        
        
//        if (firstOtpTF.text != nil) && (secondOtpTF.text != nil) && (thirdOtpTF.text != nil) && (fourthOtpTF.text != nil) && (fifthOtpTF.text != nil){
//            subBtn.isEnabled = true
//            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
//
//            firstOtpTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
//            secondOtpTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
//            thirdOtpTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
//            fourthOtpTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
//            fifthOtpTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
//
//        }else{
//            subBtn.isEnabled = false
//            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
//
//            secondOtpTF.layer.borderColor =  #colorLiteral(red: 0.3852982521, green: 0.3852982521, blue: 0.3852982521, alpha: 1)
//            thirdOtpTF.layer.borderColor =  #colorLiteral(red: 0.3852982521, green: 0.3852982521, blue: 0.3852982521, alpha: 1)
//            fourthOtpTF.layer.borderColor =  #colorLiteral(red: 0.3852982521, green: 0.3852982521, blue: 0.3852982521, alpha: 1)
//            fifthOtpTF.layer.borderColor =  #colorLiteral(red: 0.3852982521, green: 0.3852982521, blue: 0.3852982521, alpha: 1)
//        }
//    }
    
    @IBAction func resendBtnClicked(_ sender: Any) {
        
        
        
                // Call the API to reset the password
                ApiManager.shared.forgotPassword(email: "\(emailview)") { result in
                    switch result {
                    case .success(let model):
                        // Handle success
                        self.forgotModel = model
                        if model.code == "200" {
                            let alert = UIAlertController(title: "Message", message: model.message.debugDescription, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true)
                            print(model.message)
                            
                        }else if  model.code == "400"{
                            self.subBtn.stopLoading()
                     
                            let alert = UIAlertController(title: "Error!", message: model.message.debugDescription, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true)
                            print(model.message)
                        } else{
                           
                            let alert = UIAlertController(title: "Error!", message: model.message.debugDescription, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                            }
                        }
                    case .failure(let error):
                        // Handle failure
                        print("Error: \(error.localizedDescription)")
                    }
                }
            
        
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        
        subBtn.showLoading()
       // let keyText = signUpEmail
        let otpText = "\(self.firstOtpTF.text ?? "")\(self.secondOtpTF.text ?? "")\(self.thirdOtpTF.text ?? "")\(self.fourthOtpTF.text ?? "")\(self.fifthOtpTF.text ?? "")"
//        UserDefaults.standard.set(keyText, forKey: "otpemail")
//        UserDefaults.standard.set(otpText, forKey: "otpkey")
        ApiManager.shared.userTokenforgot(userToken: otpText) { result in
            switch result {
                case .success(let model):
                self.otpModel = model
                self.subBtn.stopLoading()

                print("print model:\(model)")
                let code = model.code.trimmingCharacters(in: .whitespacesAndNewlines)
                if code == "200" {
                    let alertController = UIAlertController(title:"Success!", message: model.message, preferredStyle: .alert)
                    let button = UIAlertAction(title: "Ok", style: .default) { _ in
//                        let vc  = self?.storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
//                        vc.signUpEmail = emailField
//                    vc.modalPresentationStyle = .fullScreen
//                    self?.present(vc, animated: true)
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetNewPassViewController") as! SetNewPassViewController
                        vc.userID = model.data?[0].userId ?? "0"
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                    alertController.addAction(button)
                    self.present(alertController, animated: true)
                   
                }else{
                    self.subBtn.stopLoading()
                    self.firstOtpTF.layer.borderColor = UIColor.red.cgColor
                    self.secondOtpTF.layer.borderColor = UIColor.red.cgColor
                    self.thirdOtpTF.layer.borderColor = UIColor.red.cgColor
                    self.fourthOtpTF.layer.borderColor = UIColor.red.cgColor
                    self.fifthOtpTF.layer.borderColor = UIColor.red.cgColor
                    let alert = UIAlertController(title: "Error!", message: model.message, preferredStyle: .alert)
                    let alertButton = UIAlertAction(title: "Ok", style: .cancel)
                    alert.addAction(alertButton)
                    self.present(alert, animated: false)
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("error qaqa")
            }
        }

    }


    
    @IBAction func seePasswordBtn(_ sender: UIButton) {
        if isClicked {
            eyeBtn.setImage(UIImage(named: "openeye"), for: .normal)
            firstOtpTF.isSecureTextEntry = false
            secondOtpTF.isSecureTextEntry = false
            thirdOtpTF.isSecureTextEntry = false
            fourthOtpTF.isSecureTextEntry = false
            fifthOtpTF.isSecureTextEntry = false
            isClicked = false
            
        } else {
            eyeBtn.setImage(UIImage(named: "EyeClossvg"), for: .normal)
            firstOtpTF.isSecureTextEntry = true
            secondOtpTF.isSecureTextEntry = true
            thirdOtpTF.isSecureTextEntry = true
            fourthOtpTF.isSecureTextEntry = true
            fifthOtpTF.isSecureTextEntry = true
            isClicked = true
        }
    }
    
}
