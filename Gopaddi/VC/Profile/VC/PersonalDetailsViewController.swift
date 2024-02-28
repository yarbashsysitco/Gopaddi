//
//  PersonalDetailsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 09/01/23.
//

import UIKit

class PersonalDetailsViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profilePicL: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var proceedBtn: UIButton!
    var imagePicker = UIImagePickerController()
    var pickerView = UIPickerView()
    var fullBase64String : String?
    var user = String()
    var userkey = String()
    let apiManager = ApiManager()
    var personalModel : PersonalDetModel?
    var subscriptionModel : UserSubscription?
    let genders = ["Select","Male","Female"]
    var uname : String?
    var interest : [String]?
    var datePicker = UIDatePicker()
    let isInterest = UserDefaults.standard.string(forKey: "isInterest")
    let personal = UserDefaults.standard.string(forKey: "personal")
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        //        proceedBtn.isEnabled = false
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagePickBtnClicked))
                imageView.isUserInteractionEnabled = true
                imageView.image = imageView.image?.withTintColor(.label, renderingMode: .alwaysTemplate)
                imageView.addGestureRecognizer(tapGesture)
                userkey = UserDefaults.standard.string(forKey: "gkey") ?? (UserDefaults.standard.string(forKey: "logkey") ?? UserDefaults.standard.string(forKey: GlobalConstants.userLoginKeys.key))!
                configurePicker()
                callApi()
    }
    private func callApi(){
        apiManager.subscription(userKey: userkey) { result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    self.subscriptionModel = model
                    self.uname = self.subscriptionModel?.personal?[0].uname
                    
                    if let interestsArray = model.interests, let interests = interestsArray.first, !interests.isEmpty {
                        print("setvalu")
                        UserDefaults.standard.set("false", forKey: "isInterest")
                    } else {
                        print("Notvalu")
                        UserDefaults.standard.set("true", forKey: "isInterest")
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func configurePicker(){
        gender.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton  = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        dob.inputAccessoryView = toolBar
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dob.inputView = datePicker
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == gender {
            proceedBtn.isEnabled = true

        }
    }
    @objc private func donePressed() {
        let formatter = DateFormatter()
        
        //        formatter.dateFormat = "dd/MM/yyyy"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(false)
    }
    
   @objc func imagePickBtnClicked() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image             = info[UIImagePickerController.InfoKey.originalImage]as! UIImage
        let imageData:NSData = image.jpegData(compressionQuality: 0.60)! as NSData
        print(imageData.count)
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        fullBase64String = "data:@file/jpeg;base64,\(strBase64))"
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            
        }
        else{
            dismiss(animated: true)
        }
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    func showAlert(title: String, message: String) {
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          let alertButton = UIAlertAction(title: "Ok", style: .default) { _ in
              // Handle the alert action if needed
          }
          alert.addAction(alertButton)
          self.present(alert, animated: true)
      }
    @IBAction func proceedBtnClicked(_ sender: Any) {
        
        if userName.text!.isEmpty || dob.text!.isEmpty || gender.text!.isEmpty {          // validating textfields
            showAlert(title: "Validation Error", message: "Please Enter All fields Mantatory")
        }
        else if userName.text!.isEmpty {
            showAlert(title: "Validation Error", message: "Please enter a user name.")
        }
        else if dob.text!.isEmpty {
            showAlert(title: "Validation Error", message: "Please enter your date of birth.")
        }else if gender.text!.isEmpty{
            showAlert(title: "Validation Error", message: "Please select your gender.")
        }
        else {
            guard let profilePicL = fullBase64String else { return }
            guard let userNameT = self.userName.text else { return }
            guard let dobT = self.dob.text else { return }
            guard let genderT = self.gender.text else { return }
            
            proceedBtn.showLoading()
            apiManager.personalDetails(userKey : userkey , userName : userNameT , dob : dobT, gender : genderT ,profilePic : profilePicL) { result in
                switch result {
                case.success(let model):
                    self.personalModel = model
                    DispatchQueue.main.async {[weak self] in
                        self?.callApi()
                        if model.code == "200" {
                            self?.proceedBtn.stopLoading()
                            UserDefaults.standard.set("false", forKey: "personal")
                            UserDefaults.standard.set(true, forKey: "isUserName")
                            let alert = UIAlertController(title: "Done !", message:model.message ?? "Details Uploaded" , preferredStyle: .alert)
                            let alertButoon = UIAlertAction(title: "Ok", style: .default) { _ in
                                UserDefaults.standard.set("false", forKey: "personal")
                                if let isInterest = self?.isInterest, isInterest == "true" {
                                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "InterestsViewController") as? InterestsViewController
                                    vc?.modalPresentationStyle = .fullScreen
                                    self?.present(vc!, animated: true)
                                }else{
                                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
                                    vc?.modalPresentationStyle = .fullScreen
                                    self?.present(vc!, animated: true)
                                }
                            }
                            alert.addAction(alertButoon)
                            self?.present(alert, animated: false)
                            
                        } else {
                            self?.proceedBtn.stopLoading()
                            let alert = UIAlertController(title: "Error!", message: model.message.debugDescription, preferredStyle: .alert)
                            let alertButton = UIAlertAction(title: "Ok", style: .default) { _ in
                                
                            }
                            alert.addAction(alertButton)
                            self?.present(alert, animated: true)
                        }
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func skipBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
}
extension PersonalDetailsViewController : UIPickerViewDelegate,  UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = genders[row]
        gender.resignFirstResponder()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    
}


