//
//  SignInVC.swift
//  Gopaddi
//
//  Created by jizan k on 20/12/22.
//

import UIKit
import Alamofire

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpErrorF()
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
        
    }
    @IBAction func didTapBackBtn(_ sender: Any) {
        
    }
    
    
    @objc func didTapGesture(){
        if isClicked {
            imgView.image = UIImage(systemName: "eye")?.withTintColor(.systemGray, renderingMode: .alwaysTemplate)
            
            loginPassword.isSecureTextEntry = false
            isClicked = false
        }else{
            imgView.image = UIImage(systemName: "eye.slash")?.withTintColor(.systemGray, renderingMode: .alwaysTemplate)
            
            loginPassword.isSecureTextEntry = true
            isClicked = true
        }
        imgView.image = imgView.image?.withRenderingMode(.alwaysTemplate)
    }
    @IBAction func signUpBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    @IBAction func signInBtn(_ sender: Any) {
     
        self.signInBtn.showLoading()
        guard let userEmail = loginEmail.text else { return }
        guard let password = loginPassword.text else { return }
        let token = "testoken"

        validate()
//        if isValidUser , isValidPass {
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

                    //                        {
//                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//                    let alertAction = UIAlertAction(title: "Ok", style: .cancel)
//                    alert.addAction(alertAction)
//                    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
//                        viewController.present(alert, animated: true)
//                    }
                    //                        }
                    
                    
                    // self.showAlert(message: "Invalid credentials", duration: 2.0)
                    
                    //                        let alert = UIAlertController(title: "Error!", message: "Invalid Password", preferredStyle: .alert)
                    //                        let action = UIAlertAction(title: "Ok", style: .cancel)
                    //                        alert.addAction(action)
                    //                        self.present(alert, animated: false)
                }
            }
        }
        
        
//        }
        
        
        //           if loginEmail.text == "" || loginPassword.text == "" {
        //               self.signInBtn.stopLoading()
        //               let alert = UIAlertController(title: "Please enter credentials", message: "Please enter username and password to continue", preferredStyle: .alert)
        //               alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
        //               present(alert, animated: true, completion: nil)
        //           } else {
      
        
        //               UserDefaults.standard.set(userEmail, forKey: "useremail")
        //               UserDefaults.standard.set(password, forKey: "password")
        //               UserDefaults.standard.set(token, forKey: "token")
        
        //               ApiManager.shared.signIn(useremail: userEmail, password: password, token: token) { result in
        //                   switch result {
        //                   case .success(let model):
        //                       DispatchQueue.main.async { [weak self] in
        //                           self?.registered = true
        //                           self?.signInModel = model
        //                           if model.code == "200" {
        //
        //
        //                               print("okokokookokok")
        //                               self?.signInBtn.stopLoading()
        //                               UserDefaults.standard.set(model.data[0].firstName, forKey: "firstname")
        //                               print("\(String(describing: model.data[0].firstName))")
        //
        //
        //                           } else {
        //                               print("nothellloo")
        //                           }
        //                       }
        //                   case .failure(_):
        //                       DispatchQueue.main.async {
        //                           self.signInBtn.stopLoading()
        //                           let alert = UIAlertController(title: "Incorrect Credentials", message: "The Email-id field must contain a valid email address.", preferredStyle: .alert)
        //                           let action = UIAlertAction(title: "Ok", style: .cancel)
        //                           alert.addAction(action)
        //                           self.present(alert, animated: false)
        //                       }
        //                   }
        //               }
        //           }
        
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
        
        
    }
    
    func setUpErrorF(){
        errorPassword.isHidden = true
        errorLogin.isHidden = true
    }
    func validate(){
        guard let username = loginEmail.text else {return}
        guard let password = loginPassword.text else {return}
        
        if username.isEmpty {
            loginEmail.layer.borderColor = UIColor.red.cgColor
            errorLogin.isHidden = false
            errorLogin.text = "* Username is required"
            isValidUser = false
        }
        else if !username.isValidEmail() {
            loginEmail.layer.borderColor = UIColor.red.cgColor
            errorLogin.isHidden = false
            errorLogin.text = "* Invalid Email"
            isValidUser = false
        }
        else{
            loginEmail.layer.borderColor = UIColor.blue.cgColor
            errorLogin.isHidden = true
            isValidUser = true
        }
        if password.isEmpty {
            loginPassword.layer.borderColor = UIColor.red.cgColor
            errorPassword.isHidden = false
            errorPassword.text = "* Password is required"
            isValidPass = false
        }
        else if password.count > 12{
            loginPassword.layer.borderColor = UIColor.red.cgColor
            errorPassword.isHidden = false
            errorPassword.text = "* Password field cannot exceed 12 characters in length. "
            isValidPass = false
        }
        else{
            loginPassword.layer.borderColor = UIColor.blue.cgColor
            errorPassword.isHidden = true
            isValidPass = true
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
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

extension SignInVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
