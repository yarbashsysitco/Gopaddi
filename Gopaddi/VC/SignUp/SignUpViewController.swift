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
    
    @IBOutlet weak var ValidationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var passwuppercaseImg: UIImageView!
    @IBOutlet weak var passwlowercaseImg: UIImageView!
    @IBOutlet weak var passwnumberImg: UIImageView!
    @IBOutlet weak var passwsymbolsImg: UIImageView!
    @IBOutlet weak var passwmimimImg: UIImageView!
    
    @IBOutlet weak var hidePasswordicon1: UIImageView!
    
    @IBOutlet weak var hideCPasswordicon2: UIImageView!
    
    
    @IBOutlet weak var prifixView: MyView!
    
    @IBOutlet weak var passwordView: MyView!
    
    @IBOutlet weak var cpasswordView: MyView!
    
    var isClicked1 : Bool = true
    var isClicked2 : Bool = true
 
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
        signUpButton.isEnabled = false
        signUpButton.backgroundColor  =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)

        ValidationViewHeight.constant = 0
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
        phNoTF.delegate = self
        phNoTF.keyboardType = .numberPad
        nameTF.setPadding(20)
        lastNameTF.setPadding(20)
        emailTF.setPadding(20)
        passwordTF.setPadding(20)
        phNoTF.setPadding(20)
        conPassword.setPadding(20)
        hidePasswordicon1.image = hidePasswordicon1.image?.withRenderingMode(.alwaysTemplate)
        hidePasswordicon1.tintColor = .systemGray2
        hidePasswordicon1.isUserInteractionEnabled = true
        hideCPasswordicon2.image = hideCPasswordicon2.image?.withRenderingMode(.alwaysTemplate)
        hideCPasswordicon2.tintColor = .systemGray2
        hideCPasswordicon2.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(didTapGesture1))
        hidePasswordicon1.addGestureRecognizer(tapGesture1)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(didTapGesture2))
        hideCPasswordicon2.addGestureRecognizer(tapGesture2)
        hidePasswordicon1.image = UIImage(named: "EyeClossvg")
        hideCPasswordicon2.image = UIImage(named: "EyeClossvg")
        conPassword.isSecureTextEntry = true
    }
    
    
    @objc func didTapGesture1(){
        if isClicked1 {
            hidePasswordicon1.image = UIImage(named: "openeye")
            passwordTF.isSecureTextEntry = false
            isClicked1 = false
        }else{
            hidePasswordicon1.image = UIImage(named: "EyeClossvg")
            passwordTF.isSecureTextEntry = true
            isClicked1 = true
        }
        hidePasswordicon1.image = hidePasswordicon1.image?.withRenderingMode(.alwaysTemplate)
    }
    
    @objc func didTapGesture2(){
        if isClicked2 {
            hideCPasswordicon2.image = UIImage(named: "openeye")
            conPassword.isSecureTextEntry = false
            isClicked2 = false
        }else{
            hideCPasswordicon2.image = UIImage(named: "EyeClossvg")
            conPassword.isSecureTextEntry = true
            isClicked2 = true
        }
    }
    
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    func setFields(){
        errorName.isHidden = true
        errorEmail.isHidden = true
        errorPassword.isHidden = true
        //
        errorLNAme.isHidden = true
        errorConPassword.isHidden = true
        // errorPhNo.isHidden = true
                errorPrefix.isHidden = true
    }
    func    validateFields(){
        guard let nameField = self.nameTF.text else { return }
        guard let lastNameField = self.lastNameTF.text else { return }
        guard let emailField = self.emailTF.text else { return }
        guard let passwordField = self.passwordTF.text else { return }
        guard let conPasswordField = self.conPassword.text else { return }
        guard let PrefixField  = self.phNoTF.text else { return }
        isValid = false
        
        if nameField.isEmpty {
            errorName.isHidden = false
            nameTF.layer.borderColor = UIColor.red.cgColor
            errorName.text = "* Empty field"
            isValidNa = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }else{
            errorName.isHidden = true
            isValidE = true
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
            signUpButton.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)

        }
        if PrefixField.isEmpty {
            errorPrefix.isHidden = false
            prifixView.layer.borderColor = UIColor.red.cgColor
            errorPrefix.text = "* Empty field"
            isValidNa = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }else{
            errorPrefix.isHidden = true
            isValidE = true
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
            signUpButton.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)


        }
        if lastNameField.isEmpty {
            errorLNAme.isHidden = false
            lastNameTF.layer.borderColor = UIColor.red.cgColor
            errorLNAme.text = "* Empty field"
            isValidE = true
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }else{
            errorLNAme.isHidden = true
            isValidE = true
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
            signUpButton.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)


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
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
        else{
            emailTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
            emailTF.textColor = .systemGray
            errorEmail.isHidden = true
            isValidE = true
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
            signUpButton.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        }
        
        if conPasswordField.isEmpty {
            errorConPassword.isHidden = false
            cpasswordView.layer.borderColor = UIColor.red.cgColor
            errorConPassword.text = "* Empty field"
            isValidCPa = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }else if !conPasswordField.isValidPassword() {
            errorConPassword.isHidden = false
            conPassword.layer.borderColor = UIColor.red.cgColor
            errorConPassword.text = "* Invalid Password"
            isValidCPa = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
        else if passwordField != conPasswordField{
            errorConPassword.isHidden = false
            cpasswordView.layer.borderColor = UIColor.red.cgColor
            errorConPassword.text = "* Password mismatch"
            isValidCPa = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
        else{
            cpasswordView.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
            conPassword.textColor = .systemGray
            errorConPassword.isHidden = true
            isValidE = true
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
            signUpButton.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        }
        
        if passwordField.isEmpty {
          errorPassword.isHidden = false
          passwordView.layer.borderColor = UIColor.red.cgColor
          errorPassword.text = "* Empty field"
          isValidPa = false
          signUpButton.alpha = 0.5
          signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
        else if !passwordField.isValidPassword(){
            errorConPassword.isHidden = false
            passwordView.layer.borderColor = UIColor.red.cgColor
            errorPassword.text = "* Invalid Password"
            isValidPa = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
        else{
            passwordTF.layer.borderColor =  #colorLiteral(red: 0.1607843137, green: 0.8901960784, blue: 0.431372549, alpha: 1)
            passwordTF.textColor = .systemGray
            errorPassword.isHidden = true
            isValidE = true
            signUpButton.isEnabled = true
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
            signUpButton.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        }
        print("isValidField\(isValid)")
       // signUpButton.isEnabled = true
        signUpButton.alpha = 1.0
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
            UIView.animate(withDuration: 0.7, delay: 0) {
                self.checkButton.layer.borderColor = UIColor.systemGray.cgColor
                self.checkButton.backgroundColor = UIColor(red: 0.2, green: 0.467, blue: 1, alpha: 1)
                self.checkButton.setImage(UIImage(named: "bg"),for: .normal)
                self.checkButton.backgroundColor = .systemBackground
                self.signUpButton.isEnabled = false
                self.signUpButton.alpha = 0.9
                self.isBoxChecked = false
            }
//            signUpButton.isEnabled = false
           
        }
    }
    
    @IBAction func prefixTapButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrefixViewController") as! PrefixViewController
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let FirstnameField = self.nameTF.text else { return }
        guard let lastNameField = self.lastNameTF.text else { return }
        guard let emailField = self.emailTF.text else { return }
        guard let passwordField = self.passwordTF.text else { return }
        guard let phNoField = self.phNoTF.text else { return }
        guard let conPasswordField = self.conPassword.text else { return }
        let prefixField = "+91"
        let phoneNoField = prefixField + phNoField
        
        apiManager.usRegistration(fname: FirstnameField, lname: lastNameField, email: emailField, phone: phNoField, password: passwordField, passconf: conPasswordField, referral: "123") { result in
            switch result {
            case.success(let model):
                self.regModel = model
                DispatchQueue.main.async {[weak self] in
                    if model.code == "202" {
                        print("success")
                        
                        let alertController = UIAlertController(title:"Success!", message: model.message, preferredStyle: .alert)
                        let button = UIAlertAction(title: "Ok", style: .default) { _ in
                            let vc  = self?.storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
                            vc.signUpEmail = emailField
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                        }
                        alertController.addAction(button)
                        self?.present(alertController, animated: true)
//                        
//                        let alert = UIAlertController(title: model.code, message:model.message ?? "Success!" , preferredStyle: .alert)
//                            let vc  = self?.storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
//                            vc.signUpEmail = emailField
//                        vc.modalPresentationStyle = .fullScreen
//                        self?.present(vc, animated: true)
                        } else {
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
    }
//    { result in
//        switch result {
//        case.success(let model):
//            self.regModel = model
//            if model.code == "202" {
//                let alertController = UIAlertController(title:"Success!", message: model.message, preferredStyle: .alert)
//                let button = UIAlertAction(title: "Ok", style: .default) { _ in
//                    let alert = UIAlertController(title: model.code, message:model.message ?? "Success!" , preferredStyle: .alert)
//                        let vc  = self?.storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
//                        vc.signUpEmail = emailField
//                    vc.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true)
//                }
//                alertController.addAction(button)
//                self.present(alertController, animated: true)
//            }else {
//                let alert = UIAlertController(title: "Error!", message: model.message, preferredStyle: .alert)
//                let alertButton = UIAlertAction(title: "Ok", style: .cancel)
//                alert.addAction(alertButton)
//                self.present(alert, animated: false)
//            }
//        case.failure(let error):
//            print(error.localizedDescription)
//            print("error qaqa")
//        }
//    }
    
    
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
        dismiss(animated: true)
    }
    @IBAction func signInBtnClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @IBAction func CpasswDidChanged(_ sender: UITextField) {
        self.ValidationViewHeight.constant = 0
        if conPassword.text?.isEmpty == true {
                // If loginEmail is empty, set border color to gray
            cpasswordView.layer.borderColor = UIColor.gray.cgColor
            //signInBtn.isEnabled = false

            } else {
                errorConPassword.isHidden = true

                // If loginEmail has content, set border color to blue
                cpasswordView.layer.borderColor = UIColor.green.cgColor
//                errorLogin.isHidden = true
//                signInBtn.isEnabled = true
                nameTF.layer.borderColor = UIColor.gray.cgColor
                emailTF.layer.borderColor = UIColor.gray.cgColor
                lastNameTF.layer.borderColor = UIColor.gray.cgColor
                prifixView.layer.borderColor = UIColor.gray.cgColor
                passwordView.layer.borderColor = UIColor.gray.cgColor

            }
        
    }
    
    
    
    
    @IBAction func passtxt(_ sender: UITextField) {
        let newPassword = sender.text ?? ""
        let uppercaseCharacterSet = CharacterSet.uppercaseLetters
        let lowercaseCharacterSet = CharacterSet.lowercaseLetters
        let numbersCharacterSet = CharacterSet(charactersIn: "0123456789")
        let nonAlphanumericCharacterSet = CharacterSet(charactersIn: "(!@#$%^&*()_-+={[}]|:;'<,>.?/)")
 
        if !newPassword.isEmpty {
            UIView.animate(withDuration: 0.1, delay: 0) {
                self.ValidationViewHeight.constant = 130
            }
            if newPassword.rangeOfCharacter(from: uppercaseCharacterSet) != nil {
                passwuppercaseImg.image = UIImage(named: "Greentick")
            } else {
                passwuppercaseImg.image = UIImage(named: "Cancel")
            }
            
            if newPassword.count >= 8 {
                passwmimimImg.image = UIImage(named: "Greentick")
            } else {
                passwmimimImg.image = UIImage(named: "Cancel")
            }
            if newPassword.rangeOfCharacter(from: lowercaseCharacterSet) != nil {
                passwlowercaseImg.image = UIImage(named: "Greentick")
            } else {
                passwlowercaseImg.image = UIImage(named: "Cancel")
            }
            
            if newPassword.rangeOfCharacter(from: nonAlphanumericCharacterSet) != nil {
                passwsymbolsImg.image = UIImage(named: "Greentick")
            } else {
                passwsymbolsImg.image = UIImage(named: "Cancel")
            }
              
            if (newPassword.self.rangeOfCharacter(from: .decimalDigits) != nil) {
                passwnumberImg.image = UIImage(named: "Greentick")
            } else {
                passwnumberImg.image = UIImage(named: "Cancel")
            }
//
          
        } else {
            UIView.animate(withDuration: 0.1, delay: 0) {
                self.ValidationViewHeight.constant = 0
            }
        }
        
        if passwordTF.text?.isEmpty == true {
                // If loginEmail is empty, set border color to gray
            passwordView.layer.borderColor = UIColor.gray.cgColor
            //signInBtn.isEnabled = false

            } else {
                errorPassword.isHidden = true

                // If loginEmail has content, set border color to blue
                passwordView.layer.borderColor = UIColor.green.cgColor
//                errorLogin.isHidden = true
//                signInBtn.isEnabled = true
                nameTF.layer.borderColor = UIColor.gray.cgColor
                emailTF.layer.borderColor = UIColor.gray.cgColor
                lastNameTF.layer.borderColor = UIColor.gray.cgColor
                prifixView.layer.borderColor = UIColor.gray.cgColor
                cpasswordView.layer.borderColor = UIColor.gray.cgColor

            }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == nameTF {
            // Check if email field is empty
            if let email = textField.text, email.isEmpty {
                textField.layer.borderColor = UIColor.blue.cgColor // Change border color to blue for empty field
            } else {
                // Check if the entered email is valid
                if let email = textField.text, !email.isValidEmail() {
                    textField.layer.borderColor = UIColor.red.cgColor // Change border color to red for invalid email
                } else {
                    textField.layer.borderColor = UIColor.blue.cgColor // Change border color to blue for valid email
                }
            }
        } else if textField == emailTF {
            // Check if password field is empty
            if let password = textField.text, password.isEmpty {
                textField.layer.borderColor = UIColor.blue.cgColor // Change border color to blue for empty field
            } else {
                // Check if password length exceeds 12 characters
                if let password = textField.text, password.count > 12 {
                    textField.layer.borderColor = UIColor.red.cgColor // Change border color to red for password exceeding 12 characters
                } else {
                    textField.layer.borderColor = UIColor.blue.cgColor // Change border color to blue for valid password
                }
            }
        }
        
        guard let email = nameTF.text, let password = emailTF.text else {
            // If unable to get email or password, do nothing
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !email.isEmpty && !password.isEmpty {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
            signUpButton.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
    }
    
    @IBAction func fnameEdit(_ sender: Any) {
        if nameTF.text?.isEmpty == true {
                // If loginEmail is empty, set border color to gray
            nameTF.layer.borderColor = UIColor.gray.cgColor
            //signInBtn.isEnabled = false

            } else {
                
                errorLNAme.isHidden = true

                // If loginEmail has content, set border color to blue
                nameTF.layer.borderColor = UIColor.green.cgColor
                
                lastNameTF.layer.borderColor = UIColor.gray.cgColor
                prifixView.layer.borderColor = UIColor.gray.cgColor
                emailTF.layer.borderColor = UIColor.gray.cgColor
                passwordView.layer.borderColor = UIColor.gray.cgColor
                cpasswordView.layer.borderColor = UIColor.gray.cgColor

//                errorLogin.isHidden = true
//                signInBtn.isEnabled = true

            }
        
    }
    @IBAction func lnameEdit(_ sender: Any) {
        if lastNameTF.text?.isEmpty == true {
                // If loginEmail is empty, set border color to gray
            lastNameTF.layer.borderColor = UIColor.gray.cgColor
            //signInBtn.isEnabled = false

            } else {
                errorName.isHidden = true

                // If loginEmail has content, set border color to blue
                lastNameTF.layer.borderColor = UIColor.green.cgColor
//                errorLogin.isHidden = true
//                signInBtn.isEnabled = true
                nameTF.layer.borderColor = UIColor.gray.cgColor
                prifixView.layer.borderColor = UIColor.gray.cgColor
                emailTF.layer.borderColor = UIColor.gray.cgColor
                passwordView.layer.borderColor = UIColor.gray.cgColor
                cpasswordView.layer.borderColor = UIColor.gray.cgColor

            }
    }
    @IBAction func emailEdit(_ sender: Any) {
        if emailTF.text?.isEmpty == true {
                // If loginEmail is empty, set border color to gray
            emailTF.layer.borderColor = UIColor.gray.cgColor
            //signInBtn.isEnabled = false

            } else {
                errorEmail.isHidden = true

                // If loginEmail has content, set border color to blue
                emailTF.layer.borderColor = UIColor.green.cgColor
//                errorLogin.isHidden = true
//                signInBtn.isEnabled = true
                nameTF.layer.borderColor = UIColor.gray.cgColor
                prifixView.layer.borderColor = UIColor.gray.cgColor
                lastNameTF.layer.borderColor = UIColor.gray.cgColor
                passwordView.layer.borderColor = UIColor.gray.cgColor
                cpasswordView.layer.borderColor = UIColor.gray.cgColor


            }
        
    }
    @IBAction func prifixEdit(_ sender: Any) {
        if phNoTF.text?.isEmpty == true {
                // If loginEmail is empty, set border color to gray
            prifixView.layer.borderColor = UIColor.gray.cgColor
            //signInBtn.isEnabled = false

            } else {
                errorPrefix.isHidden = true

                // If loginEmail has content, set border color to blue
                prifixView.layer.borderColor = UIColor.green.cgColor
//                errorLogin.isHidden = true
//                signInBtn.isEnabled = true
                nameTF.layer.borderColor = UIColor.gray.cgColor
                emailTF.layer.borderColor = UIColor.gray.cgColor
                lastNameTF.layer.borderColor = UIColor.gray.cgColor
                passwordView.layer.borderColor = UIColor.gray.cgColor
                cpasswordView.layer.borderColor = UIColor.gray.cgColor


            }
    }
     @IBAction func passEdit(_ sender: Any) {
    }  
    @IBAction func cpassEdit(_ sender: Any) {
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
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true
        }
    }
 

