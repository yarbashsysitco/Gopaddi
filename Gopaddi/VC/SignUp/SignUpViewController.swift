//
//  SignUpViewController.swift
//  Gopaddi
//
//  Created by jizan k on 12/06/23.
//

import UIKit

class SignUpViewController: UIViewController {
    let apiManager = ApiManager()
    var regModel : Register?
    var membershipData = [ResultData]()
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var termsCheckBox: UIButton!
    @IBOutlet weak var referal: UITextField!
    @IBOutlet weak var conPassword: UITextField!
    @IBOutlet weak var prefixTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phNoTF: UITextField!
    
    @IBOutlet weak var dropDownPrefix: UIButton!
    @IBOutlet weak var errorConPassword: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var errorPhNo: UILabel!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorLNAme: UILabel!
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorPrefix: UILabel!
    
    var isBoxChecked : Bool = false
    var isValid : Bool = true
    var isValidNa : Bool = true
    var isValidPhNo : Bool = true
    var isValidLNa : Bool = true
    var isValidPa : Bool = true
    var isValidCPa : Bool = true
    var isValidE : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // prefixTF.delegate = self
        signUpButton.isEnabled = false
        setFields()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        apiManager.memebership {  result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.sync {
                    self.membershipData = model
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    func setFields(){
        errorName.isHidden = true
        errorEmail.isHidden = true
//
        errorLNAme.isHidden = true
        errorConPassword.isHidden = true
       // errorPhNo.isHidden = true
//        errorPrefix.isHidden = true
    }
    func    validateFields(){
        guard let nameField = self.nameTF.text else { return }
        guard let lastNameField = self.lastNameTF.text else { return }
        guard let emailField = self.emailTF.text else { return }
        guard let passwordField = self.passwordTF.text else { return }
        guard let conPasswordField = self.conPassword.text else { return }
        isValid = false
        
        if nameField.isEmpty {
            errorName.isHidden = false
            nameTF.layer.borderColor = UIColor.red.cgColor
            errorName.text = "* Empty field"
            isValidNa = false
        }
        else if !nameField.isValid(name: nameField) {
            errorName.isHidden = false
            nameTF.layer.borderColor = UIColor.red.cgColor
            errorName.text = "* Invalid Name"
            isValidNa = false
        }
        else{
            nameTF.layer.borderColor = UIColor.blue.cgColor
            nameTF.textColor = .systemGray
            errorName.isHidden = true
            isValidNa = true
        }
        if lastNameField.isEmpty {
            errorLNAme.isHidden = false
            lastNameTF.layer.borderColor = UIColor.red.cgColor
            errorLNAme.text = "* Empty field"
            isValidLNa = false
        }
        else if !lastNameField.isValid(name: lastNameField) {
            errorLNAme.isHidden = false
            lastNameTF.layer.borderColor = UIColor.red.cgColor
            errorLNAme.text = "* Invalid Name"
            isValidLNa = false
        }
        else{
            lastNameTF.layer.borderColor = UIColor.blue.cgColor
            lastNameTF.textColor = .systemGray
            errorLNAme.isHidden = true
            isValidLNa = true
        }
        
        if emailField.isEmpty {
            errorEmail.isHidden = false
            emailTF.layer.borderColor = UIColor.red.cgColor
            errorEmail.text = "* Empty field"
            isValidE = false
        }
        else if !emailField.isValidEmail() {
            errorEmail.isHidden = false
            emailTF.layer.borderColor = UIColor.red.cgColor
            errorEmail.text = "* Invalid Email"
            isValidE = false
        }
        else{
            emailTF.layer.borderColor = UIColor.blue.cgColor
            emailTF.textColor = .systemGray
            errorEmail.isHidden = true
            isValidE = true
        }
//        if !prefixTF.text!.isEmpty  {
//            prefixTF.layer.borderColor = UIColor.blue.cgColor
//        }
//        
        if !phNoTF.text!.isEmpty {
            phNoTF.layer.borderColor = UIColor.blue.cgColor
        }
        if passwordField.isEmpty {
//            errorPassword.isHidden = false
//            passwordTF.layer.borderColor = UIColor.red.cgColor
//            errorPassword.text = "* Empty field"
            isValidPa = false
        }
        else if !passwordField.isValidPassword(){
            errorConPassword.isHidden = false
            passwordTF.layer.borderColor = UIColor.red.cgColor
//            errorPassword.text = "* Invalid Password"
            isValidPa = false
        }
        else{
            passwordTF.layer.borderColor = UIColor.blue.cgColor
            passwordTF.textColor = .systemGray
//            errorPassword.isHidden = true
            isValidPa = true
        }
        if conPasswordField.isEmpty {
            errorConPassword.isHidden = false
            conPassword.layer.borderColor = UIColor.red.cgColor
            errorConPassword.text = "* Empty field"
            isValidCPa = false
        }else if !conPasswordField.isValidPassword() {
            errorConPassword.isHidden = false
            conPassword.layer.borderColor = UIColor.red.cgColor
            errorConPassword.text = "* Invalid Password"
            isValidCPa = false
        }
        else if passwordField != conPasswordField{
            errorConPassword.isHidden = false
            conPassword.layer.borderColor = UIColor.red.cgColor
            errorConPassword.text = "* Password mismatch"
            isValidCPa = false
        }
        else{
            conPassword.layer.borderColor = UIColor.blue.cgColor
            conPassword.textColor = .systemGray
            errorConPassword.isHidden = true
            isValidCPa = true
        }
        print("isValidField\(isValid)")
    }
    @IBAction func checkButtonClicked(_ sender: Any) {
        validateFields()
        if (isBoxChecked == false)
        {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
                self.checkButton.layer.borderColor = UIColor.blue.cgColor
                self.checkButton.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
                self.checkButton.setImage(UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
                self.checkButton.tintColor = .systemBackground
                self.signUpButton.isEnabled = true
                self.signUpButton.alpha = 1
                self.isBoxChecked = true
            }
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.checkButton.layer.borderColor = UIColor.systemGray.cgColor
                self.checkButton.backgroundColor = .systemBackground
                self.signUpButton.isEnabled = false
                self.signUpButton.alpha = 0.9
                self.isBoxChecked = false
            }
        }
    }
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let nameField = self.nameTF.text else { return }
        guard let lastNameField = self.lastNameTF.text else { return }
        guard let emailField = self.emailTF.text else { return }
        guard let passwordField = self.passwordTF.text else { return }
        guard let phNoField = self.phNoTF.text else { return }
        let referalField = "12345"
        guard let conPasswordField = self.conPassword.text else { return }
        let prefixField = "+91"
        let phoneNoField = prefixField + phNoField
        let token = "gv4Gp1OeZhF5eBNU7vDjDL-yqZ6vrCfdCzF7HGVMiCs"
        validateFields()
        if isValidNa, isValidE , isValidPa , isValidCPa , isValidLNa == true{
            isValid = true
        }
        if isValid {
            apiManager.userRegistration(membership : "gopal", plan : "gold", fname: nameField, lname: lastNameField, email: emailField, phone: phoneNoField, password: passwordField, passconf: conPasswordField, referral: referalField, token: token) { result in
                switch result {
                case.success(let model):
                    self.regModel = model
                    DispatchQueue.main.async {[weak self] in
                        if model.code == "200" {
                            let alert = UIAlertController(title: model.code, message:model.message ?? "Success!" , preferredStyle: .alert)
                            let alertButoon = UIAlertAction(title: "Ok", style: .default) { _ in
                                let vc  = self?.storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
                                vc.signUpEmail = emailField
                                self?.present(vc, animated: false)
                            }
                            alert.addAction(alertButoon)
                            self?.present(alert, animated: false)
                            
                        } else if model.code == "303" {
                            let alert = UIAlertController(title: model.code, message:model.message ?? "Error !" , preferredStyle: .alert)
                            let alertButoon = UIAlertAction(title: "Ok", style: .default)
                            alert.addAction(alertButoon)
                            self?.present(alert, animated: false)
                        }
                        else {
                            let alertcontrollert = UIAlertController(title: "Error" , message: self?.regModel?.message ?? "Something went wrong!", preferredStyle: .alert)
                            let alertButoon = UIAlertAction(title: "Ok", style: .default)
                            alertcontrollert.addAction(alertButoon)
                            self?.present(alertcontrollert, animated: true)
                        }
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }else{
            let alertcontrollert = UIAlertController(title: "Error !" , message:  "Please Provide Required Information", preferredStyle: .actionSheet)
            let alertButoon = UIAlertAction(title: "Ok", style: .default)
            alertcontrollert.addAction(alertButoon)
            self.present(alertcontrollert, animated: true)
        }
    }
    @IBOutlet weak var backBtnClicked: UIView!
    @IBAction func privacyButtonClicked(_ sender: Any) {
        guard let urlString = URL(string: termsNCondition) else {return}
        UIApplication.shared.open(urlString, options: [:], completionHandler: nil)
    }
    @IBAction func termsButtonClicked(_ sender: Any) {
        guard let urlString = URL(string: termsNCondition) else {return}
        UIApplication.shared.open(urlString, options: [:], completionHandler: nil)
    }
    @IBAction func didTapBackBtn(_ sender: Any) {
        dismiss(animated: false)
    }
    @IBAction func signInBtnClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTF {
        } else if textField == emailTF {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.blue.cgColor
        } else  if textField == prefixTF {
            let vc = CountryViewController()
            vc.tag = 1
            vc.completionHandler = { text in
                self.prefixTF.text = text.phonecode
                return text
            }
            let navVC = UINavigationController(rootViewController: vc)
            self.present(navVC, animated: true)
            textField.resignFirstResponder()
            
        } else if textField == passwordTF {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.blue.cgColor
            textField.resignFirstResponder()
            
        } else if textField == conPassword {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.blue.cgColor
            textField.resignFirstResponder()
            
        } else if textField == referal {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.blue.cgColor
            textField.resignFirstResponder()
        }
    }
}
