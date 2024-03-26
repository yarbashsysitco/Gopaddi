//
//  SetNewPassViewController.swift
//  Gopaddi
//
//  Created by jizan k on 07/03/24.
//

import UIKit

class SetNewPassViewController: UIViewController {
    
    @IBOutlet weak var subBtn: UIButton!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var cPassTF: UITextField!
    @IBOutlet weak var eyeHide1: UIButton!
    @IBOutlet weak var eyeHide2: UIButton!
    var stNewPass: ResetPasswordModel?
    var userID = String()
    var isClicked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        passTF.setPadding(20)
        cPassTF.setPadding(20)
        print("newwss")

    }
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func passEditingChanged(_ sender: UITextField) {
        guard let pass = passTF.text
        else {
            // If unable to get email or password, do nothing
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !pass.isEmpty{
            subBtn.isEnabled = false
            subBtn.alpha = 1.0
            passTF.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
        
        } else {
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            passTF.layer.borderColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        }
    }
    
    
    @IBAction func confirmPassEditingChanged(_ sender: UITextField) {
        guard let confirmpass = cPassTF.text
        else {
            // If unable to get email or password, do nothing
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !confirmpass.isEmpty{
            subBtn.isEnabled = true
            subBtn.alpha = 1.0
            subBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            cPassTF.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
        
        } else {
            subBtn.isEnabled = false
            subBtn.alpha = 0.5
            subBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            cPassTF.layer.borderColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        }
    }
    @IBAction func passEyeBtn(_ sender: UIButton) {
        if isClicked {
            eyeHide1.setImage(UIImage(named: "openeye"), for: .normal)
            passTF.isSecureTextEntry = false
            isClicked = false
        }else{
            eyeHide1.setImage(UIImage(named: "EyeClossvg"), for: .normal)
            passTF.isSecureTextEntry = true
            isClicked = true
        }
    }
    
    @IBAction func ConfirmPassEyeBtn(_ sender: UIButton) {
        if isClicked {
            eyeHide2.setImage(UIImage(named: "openeye"), for: .normal)
            cPassTF.isSecureTextEntry = false
            isClicked = false
        }else{
            eyeHide2.setImage(UIImage(named: "EyeClossvg"), for: .normal)
            cPassTF.isSecureTextEntry = true
            isClicked = true
        }
    }
    
    
    
    @IBAction func subBtn(_ sender: Any) {
        guard let passTF = passTF.text, !passTF.isEmpty else {
            // Handle case where password text field is empty
            return
        }
        guard let cPassTF = cPassTF.text, !cPassTF.isEmpty else {
            // Handle case where confirm password text field is empty
            return
        }
        
        ApiManager.shared.userResetPass(password: passTF, passconf: cPassTF, userId: "\(userID)") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    let status = model.status.trimmingCharacters(in: .whitespacesAndNewlines)
                    let code = model.code?.trimmingCharacters(in: .whitespacesAndNewlines)
                    if status == "200" {
                        
                        let alert = UIAlertController(title: "Message", message: model.alerts.debugDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoneViewController") as! DoneViewController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true)
                   
                    } else{
                        let alert = UIAlertController(title: "Message", message: model.alerts.debugDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                        }
                    }
                case .failure(let error):
                    // Handle failure
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
    }
}
