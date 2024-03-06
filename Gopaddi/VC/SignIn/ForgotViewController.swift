//
//  ForgotViewController.swift
//  Gopaddi
//
//  Created by admin on 22/09/23.
//

import UIKit

class ForgotViewController: UIViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var subBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    var forgotModel : ForgotPassword?
    
    @IBOutlet weak var warningLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial setup for UI elements
        setupUI()
        
        print("ok")
    }
    
    func setupUI() {
        subBtn.layer.cornerRadius = 5
        closeBtn.layer.cornerRadius = 5
        emailTF.layer.cornerRadius = 5
        emailTF.borderStyle = .roundedRect
        emailTF.layer.borderWidth = 1.0
        emailTF.layer.borderColor = UIColor.systemGray.cgColor
        warningLb.isHidden = true
        
        // Add a tap gesture to dismiss the keyboard when tapping outside the text field
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
        
        // Customize the appearance of the view
        configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        self.contentView.alpha = 2
        self.contentView.layer.cornerRadius = 10
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        // Check if the email text field is empty
        if let email = emailTF.text, email.isEmpty {
            // Update the UI when email is empty
            emailTF.layer.borderColor = UIColor.red.cgColor
            warningLb.isHidden = false
            warningLb.text = "Please add your email address"
        } else if !isValidEmail(email: emailTF.text ?? "") {
            // Check if the entered email is valid
            emailTF.layer.borderColor = UIColor.red.cgColor
            warningLb.isHidden = false
            warningLb.text = "Invalid email format"
        } else {
            // Reset the border color and proceed with API call
            emailTF.layer.borderColor = UIColor.systemGray.cgColor
            warningLb.isHidden = true
            
            // Get the email from the text field
            guard let email = emailTF.text else { return }
            
            // Call the API to reset the password
            ApiManager.shared.forgotPassword(email: email) { result in
                switch result {
                case .success(let model):
                    // Handle success
                    self.forgotModel = model
                    let alert = UIAlertController(title: "Message", message: model.message.debugDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                        // Dismiss the current view controller
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    print(model.message)
                case .failure(let error):
                    // Handle failure
                    print("Error: \(error.localizedDescription)")
                    self.emailTF.placeholder = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
