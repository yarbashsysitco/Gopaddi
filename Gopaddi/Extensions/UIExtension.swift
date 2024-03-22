//
//  UIViewExtension.swift
//  Gopaddi
//
//  Created by jizan k on 15/12/22.
//

import UIKit

extension UIView{
    @IBInspectable var cornerR : CGFloat{
        get {
            return self.cornerR
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
}
extension UIButton{
@IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
@IBDesignable
class MyView : UIView {
    @IBInspectable var borderColor: UIColor? {
            get {
                guard let cgColor = layer.borderColor else {
                    return nil
                }
                return UIColor(cgColor: cgColor)
            }
            set { layer.borderColor = newValue?.cgColor }
        }

        @IBInspectable var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
}

@IBDesignable
class TextView: UITextView {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

extension String {
    func isValid(name: String) -> Bool {
          let regex = "[A-Za-z]{2,}"
          let test = NSPredicate(format: "SELF MATCHES %@", regex)
          let result = test.evaluate(with: name)
          return result
      }
    func isValidEmail() -> Bool {
        let inputRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let inputPred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputPred.evaluate(with: self)
    }
   func isValidPhone(phone: String) -> Bool {
    let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
       let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
       return phoneTest.evaluate(with: phone)
   }
    func isValidPassword() -> Bool {
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx =  "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    } 
    
    func isValidPasswordNumber() -> Bool {
           // Check if the password contains at least one digit
           let digitRange = self.rangeOfCharacter(from: .decimalDigits)
           return digitRange != nil// Check if password length is at least 8 characters
       }
    
}
extension UIView {
    static let loadingViewTag = 1223322
    func showLoading(style: UIActivityIndicatorView.Style = .large) {
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }

        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
//        loading?.backgroundColor = .systemBlue
        loading?.layer.cornerRadius = 10
        addSubview(loading!)
        
      loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}

extension UITextField {
    func setDatePickerAsInputView(target: Any, selector: Selector) {
        let screenWith = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 200, width: screenWith, height: 300))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        self.inputView = datePicker
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWith, height: 50))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancel))
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancel,flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolbar
        
    }
    @objc func tappedCancel() {
        self.resignFirstResponder()
    }
}
extension UITextField {
    
    func setupRightView(imageViewNamed: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 12, height: 12))
        imageView.image = UIImage(named: imageViewNamed)
        let imageViewConteinerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        imageViewConteinerView.addSubview(imageView)
        rightView =  imageViewConteinerView
        rightView?.tintColor  = .systemBackground
//        rightView?.tintColor  = UIColor(red: 0.634, green: 0.634, blue: 0.634, alpha: 1)
        self.rightViewMode = .always
    }
    func setupRightViewN(imageViewNamed: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 12, height: 12))
        imageView.image = UIImage(systemName: imageViewNamed)
        let imageViewConteinerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        imageViewConteinerView.addSubview(imageView)
        rightView =  imageViewConteinerView
        rightView?.tintColor  = .systemBackground
//        rightView?.tintColor  = UIColor(red: 0.634, green: 0.634, blue: 0.634, alpha: 1)
        self.rightViewMode = .always
    }
    func setupLeftView(imageViewNamed: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 16, height: 16))
        imageView.image = UIImage(named: imageViewNamed)?.withRenderingMode(.alwaysTemplate) ?? UIImage(systemName: imageViewNamed)?.withRenderingMode(.alwaysTemplate)
        let imageViewConteinerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 35))
        imageViewConteinerView.addSubview(imageView)
        leftView =  imageViewConteinerView
        leftView?.tintColor  = UIColor(red: 0.634, green: 0.634, blue: 0.634, alpha: 1)
        self.leftViewMode = .always
    }
    func setupLeftViewN(imageViewNamed: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 16, height: 16))
        imageView.image = UIImage(systemName: imageViewNamed)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemGray
        let imageViewConteinerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 35))
        imageViewConteinerView.addSubview(imageView)
        leftView =  imageViewConteinerView
        leftView?.tintColor  = UIColor(red: 0.634, green: 0.634, blue: 0.634, alpha: 1)
        self.leftViewMode = .always
    }
    func setupRightViewButton() {
        let imageButton = UIButton(frame: CGRect(x: 10, y: 10, width: 22, height: 22))
//        if !eyeIconClick {
//            imageButton.setImage(UIImage(named: "eyeClosed"), for: .normal)
//            UITextField().isSecureTextEntry = true
//        }else {
//            imageButton.setImage(UIImage(named: "eyeOpen"), for: .normal)
//            UITextField().isSecureTextEntry = false
//        }
        
        let imageViewConteinerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 35))
        imageViewConteinerView.addSubview(imageButton)
        rightView =  imageViewConteinerView
        rightView?.tintColor  = UIColor(red: 0.634, green: 0.634, blue: 0.634, alpha: 0.4)
        self.rightViewMode = .always
        imageButton.addTarget(self, action: #selector(eyeOpenAction(_ :)), for: .touchUpInside)
    }
    @objc func eyeOpenAction(_ sender : UIButton){
//        if eyeIconClick{
//            eyeIconClick = false
//        }
//        else{
//            eyeIconClick = true
//        }
        setupRightViewButton()
    }
}
class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 5,
        left: 16,
        bottom: 5,
        right: 20
    )
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
//class TextviewdWithPadding: UITextView {
//    var textPadding = UIEdgeInsets(
//        top: 5,
//        left: 16,
//        bottom: 5,
//        right: 20
//    )
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.textRect(forBounds: bounds)
//        return rect.inset(by: textPadding)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.editingRect(forBounds: bounds)
//        return rect.inset(by: textPadding)
//    }
//}
extension UITextField {
    func setPadding(_ points: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: points, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


extension UIView {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        shake.fromValue = NSValue(cgPoint: fromPoint)
        shake.toValue = NSValue(cgPoint: toPoint)
        
        layer.add(shake, forKey: "position")
        
        // Vibrate the phone
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}


extension UIViewController {
    func showAlert(message: String, duration: Double = 3.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
}
