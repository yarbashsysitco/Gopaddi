//
//  SignInVC.swift
//  Gopaddi
//
//  Created by jizan k on 20/12/22.
//

import UIKit
import Alamofire
import AuthenticationServices


class SignInVC: UIViewController{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var errorLogin: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginEmail: UITextField!
    var isClicked : Bool = true
    var forgotModel : ForgotPassword?
    let utilFunc = UtilitiesFunctions()
    var userSubscription : UserSubscription?
    var signInModel : SignInModel?
    var registered : Bool = false
    var isValidUser : Bool = false
    var isValidPass : Bool = false
    let verified = UserDefaults.standard.string(forKey: "verified")
    let isInterest = UserDefaults.standard.string(forKey: "isInterest")
    let isUserName = UserDefaults.standard.string(forKey: "isUserName")
    var finished:Bool = true
    let userisLogin = UserDefaults.standard.set("true", forKey: "finished")
    let personal = UserDefaults.standard.string(forKey: "personal")
    let MainTabBarController = UserDefaults.standard.string(forKey: "MainTabBarController")
    var keyid = String()
    var isValid = true
    var uniqeFName = String()
    var uniqeLName = String()
    var uniqeEmail = String()
    var EmailCheck : AppleSiningModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("helloo")
        setUpErrorF()
        signInBtn.isEnabled = false
        loginPassword.isSecureTextEntry = true
        loginEmail.setPadding(20)
        loginPassword.setPadding(20)
        
        UserDefaults.standard.set(true, forKey: "AppOpen")
        loginPassword.delegate = self
        loginPassword.returnKeyType = .done
        imgView.image = imgView.image?.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = .systemGray2
        imgView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapGesture))
        imgView.addGestureRecognizer(tapGesture)
        imgView.image = UIImage(named: "openeye")
        loginPassword.isSecureTextEntry = false
        
    }
    @IBAction func didTapBackBtn(_ sender: Any) {
        
    }
    
    
    @objc func didTapGesture(){
        if isClicked {
            imgView.image = UIImage(named: "openeye")
            loginPassword.isSecureTextEntry = false
            isClicked = false
        }else{
            imgView.image = UIImage(named: "EyeClossvg")
            loginPassword.isSecureTextEntry = true
            isClicked = true
        }
    }
    @IBAction func signUpBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "OnboardingAccountMain", bundle: Bundle.main).instantiateViewController(withIdentifier: "GopaddiAccountsVC") as? GopaddiAccountsVC
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
//        let vc = UIStoryboard(name: "OnboardingAccountMain", bundle: nil).instantiateViewController(withIdentifier: "ContainersGopaddiVC")as! ContainersGopaddiVC
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        
    }
    @IBAction func signInBtn(_ sender: Any) {
        
        self.signInBtn.showLoading()
        guard let userEmail = loginEmail.text, !userEmail.isEmpty else {
            self.signInBtn.stopLoading()
            showAlert(message: "Please enter your email", duration: 2.0)
            return
        }
        
        guard let password = loginPassword.text, !password.isEmpty else {
            self.signInBtn.stopLoading()
            showAlert(message: "Please enter your password", duration: 2.0)
            return
        }
        guard let userEmail = loginEmail.text else { return }
        guard let password = loginPassword.text else { return }
        let token = "testoken"
        validateFields()//        if isValidUser , isValidPass {
        UserDefaults.standard.set(userEmail, forKey: "useremail")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(token, forKey: "token")
        ApiManager.shared.signIn(useremail: userEmail, password: password, token: token) { result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async { [weak self] in
                    self?.registered = true
                    self?.signInModel = model
                    if model.code == "200" {
                        self?.signInBtn.stopLoading()
                        print("\(String(describing: model.data[0].userId))")
                        self?.utilFunc.saveLogging(true)
                        if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                            vc.modalPresentationStyle = .fullScreen
                            UserDefaults.standard.set(model.data[0].firstName, forKey: "firstname")
                            UserDefaults.standard.set(model.data[0].lastName, forKey: "lastname")
                            UserDefaults.standard.set(model.data[0].email, forKey: "logemail")
                            UserDefaults.standard.set(model.data[0].userId, forKey: "userid")
                            UserDefaults.standard.set(model.data[0].membership, forKey: "membership")
                            UserDefaults.standard.set(model.data[0].picture, forKey: "picture")
                            UserDefaults.standard.set(model.data[0].phone, forKey: "logphone")
                            UserDefaults.standard.set(model.data[0].gender, forKey: "gender")
                            UserDefaults.standard.set(model.data[0].occupation, forKey: "occupation")
                            self?.present(vc, animated: true, completion: nil)
                        }
                    } else if  model.code == "404"  {
                        self?.showAlert(message: "Invalid username or password", duration: 2.0)
                    } else if  model.code == "500"  {
                        self?.showAlert(message: "The email field must contain a valid email address.", duration: 2.0)
                    }else {
                        let alert = UIAlertController(title: "Error!", message: model.message.debugDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .default) { _ in
                            let vc  = self?.storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
                            vc.signUpEmail = userEmail
                            self?.present(vc, animated: false)
                        }
                        alert.addAction(action)
                        self?.present(alert, animated: false)
                    }
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    self.signInBtn.shake()
                    self.signInBtn.stopLoading()
                    self.showAlert(message: "Invalid username or password", duration: 2.0)
                }
            }
        }
        
        
        
    }
    //    func callSubscription(){
    //        var logkey = keyid
    //        let str = UIStoryboard(name: "Main", bundle: nil)
    //        ApiManager.shared.subscription(userKey: logkey) { result in
    //            switch result {
    //            case .success(let model):
    //                DispatchQueue.main.async {
    //
    //
    //                    //                    print(self.userSubscription?.interests as Any)
    //                    self.userSubscription = model
    //                    print("Personal: \(model.personal?[0].uname)")
    //                    print("Interests: \(model.interests)")
    //                    // Check if both personal and interests arrays are nil or empty
    //                    if let personal = model.personal?[0].uname, !personal.isEmpty {
    //                        print("setvalu")
    //                        UserDefaults.standard.set("false", forKey: "personal")
    //                    } else {
    //                        print("Notvalu")
    //                        UserDefaults.standard.set("true", forKey: "personal")
    //                    }
    //
    //                    if let interestsArray = model.interests, let interests = interestsArray.first, !interests.isEmpty {
    //                        print("setvalu")
    //                        UserDefaults.standard.set("false", forKey: "isInterest")
    //                    } else {
    //                        print("Notvalu")
    //                        UserDefaults.standard.set("true", forKey: "isInterest")
    //                    }
    //
    //                }
    //            case .failure(let error):
    //                print("API Call Error: \(error.localizedDescription)")
    //            }
    //        }
    //    }
    
    @IBAction func forgotBtnClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "ForgotMain", bundle: nil).instantiateViewController(withIdentifier: "ForgotViewController")as! ForgotViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    @IBAction func googleSignBtnClicked(_ sender: Any) {
        // Create an instance of ASAuthorizationAppleIDProvider
          let appleIDProvider = ASAuthorizationAppleIDProvider()

          // Create a new Apple ID authorization request
          let request = appleIDProvider.createRequest()

          // Specify the requested scopes
          request.requestedScopes = [.fullName, .email]

          // Create an instance of ASAuthorizationController with the authorization request
          let authorizationController = ASAuthorizationController(authorizationRequests: [request])

          // Set the delegate for the authorization controller
          authorizationController.delegate = self

          // Present the authorization controller to initiate the sign in process
          authorizationController.performRequests()
        
    }
    
    func setUpErrorF(){
        errorPassword.isHidden = true
        errorLogin.isHidden = true
    }
    func    validateFields(){
        guard let userEmail = loginEmail.text else {return}
        guard let password = loginPassword.text else {return}
        isValid = true
        
        if userEmail.isEmpty {
            self.signInBtn.stopLoading()
            errorLogin.isHidden = false
            loginEmail.layer.borderColor = UIColor.red.cgColor
            errorLogin.text = "* Empty field"
            isValid = false
            signInBtn.alpha = 0.5
            signInBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
        else if !userEmail.isValidEmail() {
            self.signInBtn.stopLoading()
            errorLogin.isHidden = false
            loginEmail.layer.borderColor = UIColor.red.cgColor
            errorLogin.text = "* Invalid Email"
            isValid = false
            signInBtn.alpha = 0.5
            signInBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
        else{
            loginEmail.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
            errorLogin.isHidden = true
            isValid = false
            signInBtn.isEnabled = true
            signInBtn.alpha = 1.0
            signInBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        }
        
        if password.isEmpty {
            self.signInBtn.stopLoading()
            errorPassword.isHidden = false
            loginPassword.layer.borderColor = UIColor.red.cgColor
            errorPassword.text = "* Empty field"
            isValid = false
            signInBtn.alpha = 0.5
            signInBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }else if !password.isValidPassword() {
            self.signInBtn.stopLoading()
            errorPassword.isHidden = false
            loginPassword.layer.borderColor = UIColor.red.cgColor
            errorPassword.text = "* Invalid Password"
            isValid = false
            signInBtn.alpha = 0.5
            signInBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }else{
            loginPassword.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
            //            conPassword.textColor = .systemGray
            errorPassword.isHidden = true
            isValid = true
            signInBtn.isEnabled = true
            signInBtn.alpha = 1.0
            signInBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        }
        
    }
    
    
    
    
    //    func validate(){
    //        guard let username = loginEmail.text else {return}
    //        guard let password = loginPassword.text else {return}
    //
    //        if username.isEmpty {
    //            loginEmail.layer.borderColor = UIColor.red.cgColor
    //            errorLogin.isHidden = false
    //            errorLogin.text = "* Username is required"
    //            isValidUser = false
    //        }
    //        else if !username.isValidEmail() {
    //            loginEmail.layer.borderColor = UIColor.red.cgColor
    //            errorLogin.isHidden = false
    //            errorLogin.text = "* Invalid Email"
    //            isValidUser = false
    //        }
    //        else{
    //            loginEmail.layer.borderColor = UIColor.green.cgColor
    //            errorLogin.isHidden = true
    //            isValidUser = true
    //        }
    //        if password.isEmpty {
    //            loginPassword.layer.borderColor = UIColor.red.cgColor
    //            errorPassword.isHidden = false
    //            errorPassword.text = "* Password is required"
    //            isValidPass = false
    //        }
    //        else if password.count > 12{
    //            loginPassword.layer.borderColor = UIColor.red.cgColor
    //            errorPassword.isHidden = false
    //            errorPassword.text = "* Password field cannot exceed 12 characters in length. "
    //            isValidPass = false
    //        }
    //        else{
    //            loginPassword.layer.borderColor = UIColor.green.cgColor
    //            errorPassword.isHidden = true
    //            isValidPass = true
    //        }
    //    }
    @IBAction func backBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    
        
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        signInBtn.isEnabled = true

        if textField == loginEmail {
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
        } else if textField == loginPassword {
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
        
        guard let email = loginEmail.text, let password = loginPassword.text else {
            // If unable to get email or password, do nothing
            signInBtn.isEnabled = false
            signInBtn.alpha = 0.5
            signInBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
            return
        }
        
        // Check if both email and password are not empty
        if !email.isEmpty && !password.isEmpty {
            signInBtn.isEnabled = true
            signInBtn.alpha = 1.0
            signInBtn.backgroundColor =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        } else {
            signInBtn.isEnabled = false
            signInBtn.alpha = 0.5
            signInBtn.backgroundColor =  #colorLiteral(red: 0.9058823529, green: 0.9411764706, blue: 1, alpha: 1)
        }
    }
    //    func textFieldDidChangeSelection(_ textField: UITextField) {
    //
    //    }
    
    
    @IBAction func emails(_ sender: Any) {
        if loginEmail.text?.isEmpty == true {
            signInBtn.isEnabled = false

            // If loginEmail is empty, set border color to gray
            loginEmail.layer.borderColor = UIColor.gray.cgColor
            signInBtn.isEnabled = false
            
        } else {
            signInBtn.isEnabled = true
            // If loginEmail has content, set border color to blue
            loginEmail.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
            errorLogin.isHidden = true
            signInBtn.isEnabled = true
            loginPassword.layer.borderColor = UIColor.gray.cgColor
            
        }
        
        
    }
    @IBAction func passworDidEdit(_ sender: Any) {
        if loginPassword.text?.isEmpty == true {
            // If loginEmail is empty, set border color to gray
            loginPassword.layer.borderColor = UIColor.gray.cgColor
            signInBtn.isEnabled = false
        } else {
            // If loginEmail has content, set border color to blue
            loginPassword.layer.borderColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
//            loginPassword.layer.shadowColor =  #colorLiteral(red: 0.4823529412, green: 0.3803921569, blue: 1, alpha: 1)
//            loginPassword.layer.shadowOffset = CGSize(width: 0, height: 2)
//            loginPassword.layer.shadowOpacity = 0.9
//            loginPassword.layer.shadowRadius = 2
                        signInBtn.isEnabled = true

            errorPassword.isHidden = true
            signInBtn.isEnabled = true
            
            loginEmail.layer.borderColor = UIColor.gray.cgColor
            
            
        }
    }
    
    func emailCheking(){
        if !uniqeEmail.isEmpty {
//        self.loadingIndicator.startAnimating()
            var pic = "https://vgtechdemo.com/tokyodevbckend/assets/images/placeholder/avatar.png%22"
            ApiManager.shared.uniqueemailCheck(email: uniqeEmail, fname: uniqeFName, lname: uniqeLName, media: "apple", membership: "gopal", browser: "safari", platform: "iOS", device: "iPhone", ip_address: "192.122.56.10", location: "Kochi", picture: pic) { result in
                switch result {
                case.success(let model):
                    DispatchQueue.main.async { [weak self] in
                        self?.EmailCheck = model
                        if model.code == "200"{
                            
                           print("appple")
                            
                            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                                vc.modalPresentationStyle = .fullScreen
                                UserDefaults.standard.set(model.data[0].user[0].Userid, forKey: "userid")
                                self?.present(vc, animated: true, completion: nil)
                            }
                            
//                            print( model.data[0].user[0].Userid)
                         
//                            self?.dismiss(animated: true)
//                            self?.loadingIndicator.stopAnimating()
//                            let str = UIStoryboard(name: "Main", bundle: nil)
//                            let vc = str.instantiateViewController(identifier: "PreselectionVC")as! PreselectionVC
//                            UserDefaults.standard.set(self?.uniqeEmail, forKey: "uniqeEmail")
//                            UserDefaults.standard.set(self?.uniqeName, forKey: "uniqeName")
//                            UserDefaults.standard.set(self?.socialLogin, forKey: "loginCode")
//
//                            self?.present(vc, animated: true)
    //                        let alert = UIAlertController(title: "Error!", message: model.message.debugDescription, preferredStyle: .alert)
    //                        let action = UIAlertAction(title: "Ok", style: .cancel)
    //                        alert.addAction(action)
    //                        self?.present(alert, animated: false)
                        }else{
//                            self?.loadingIndicator.stopAnimating()
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
                            self?.utilFunc.saveLogging(true)
                            self!.present(nextViewController, animated: true)
                            print("susses")
                        }
                    }
                case.failure(_):
                    DispatchQueue.main.async {
                    }
                }
            }
        } else {
            // If email is empty, show the alert
            OkActionConfirmationAlert()
        }
    }
    func OkActionConfirmationAlert() {
        let alert = UIAlertController(title: "alert", message: "You have already signed in with your apple ID. Please go to your phone settings, signout your apple ID in gopaddi and re-signin. ", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let OkAction = UIAlertAction(title: "Ok", style: .destructive) { _ in
//            GlobalvibratePhone.vibratePhone()

//            self.deleteAccounts()
        }

        alert.addAction(OkAction)

        present(alert, animated: true, completion: nil)
    }
    
    
}
extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginEmail {
            loginPassword.becomeFirstResponder()
        } else if textField == loginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension SignInVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
extension SignInVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            UserDefaults.standard.set(userIdentifier, forKey: "appleUserID")

            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            // Use this information as needed
                        print("User Identifier: \(userIdentifier)")
                        print("User Identifier: \(fullName)")
                        print("User Identifier: \(email)")
            if let name = fullName {
                let Fname = name.givenName
                let Lname = name.familyName
                self.uniqeFName = Fname ?? ""
                self.uniqeLName = Lname ?? ""
             }
             if let userEmail = email {
                 print("Email: \(userEmail)")
                 self.uniqeEmail = userEmail
             }
            self.emailCheking()
        }
    }


    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle sign-in error
    }
    
    
}
