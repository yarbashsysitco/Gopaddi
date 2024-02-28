//
//  ProfileInfoViewController.swift
//  Gopaddi
//
//  Created by jizan k on 01/03/23.
//

import UIKit

class ProfileInfoViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var phErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var lineViewTopCostraints: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var viewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var ocuupationTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var imageChangeBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var saveView: UIView!
    var imagePicker = UIImagePickerController()
    let gender = ["Not Prefer to Say","male","female"]
    var suggestionModel : Suggestion?
    let apiManager = ApiManager()
    var imageChangeModel : profileImgChange?
    var response : CommonResponse?
    var isValidNa : Bool = false
    var isValidE : Bool = false
    var isValidph : Bool = false
    var picture : String?
    var verified : String?
    var isEditClicked : Bool = false
    var fullBase64String : String?
    var pickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageChangeBtn.isEnabled = false
        profileInfo()
        userNameTF.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        ocuupationTF.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        lineViewTopCostraints.constant = 8
        viewHeightConstraints.constant = 0
        nameErrorLbl.isHidden = true
        emailErrorLbl.isHidden = true
        phErrorLbl.isHidden = true
        genderTF.inputView = pickerView
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.label.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        saveView.isHidden = true
        editBtn.isHidden = false
        TFDisable()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
               tapGesture.delegate = self
               self.view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
          self.view.endEditing(true)
      }
    private func TFEnable(){
        nameTF.isEnabled = true
        userNameTF.isEnabled = true
        ocuupationTF.isEnabled = true
        emailTF.isEnabled = true
        phoneTF.isEnabled = true
        phoneTF.isEnabled = true
        genderTF.isEnabled = true
        imageChangeBtn.isEnabled = true

        
    }
    private func TFDisable(){
        nameTF.isEnabled = false
        userNameTF.isEnabled = false
        ocuupationTF.isEnabled = false
        emailTF.isEnabled = false
        phoneTF.isEnabled = false
        phoneTF.isEnabled = false
        genderTF.isEnabled = false
        imageChangeBtn.isEnabled = false

    }
    private func callSuggestionAPI(){
        let userKey = UserDefaults.standard.string(forKey: "logkey")
        guard let userid = userNameTF.text else{return}
        apiManager.userIDSuggestion(userKey: userKey!, userid: userid){ result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.suggestionModel = model
                    if model.code == "200"{
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func profileInfo(){
        let name = UserDefaults.standard.string(forKey: "logname") ?? ""
        let occupation = UserDefaults.standard.string(forKey: "occupation") ?? ""
        let email = UserDefaults.standard.string(forKey: "logemail") ?? ""
        let logphone = UserDefaults.standard.string(forKey: "logphone") ?? ""
        let gender = UserDefaults.standard.string(forKey: "gender") ?? ""
        let userid = UserDefaults.standard.string(forKey: "userid") ?? ""
        nameTF.text = name
        userNameTF.text = userid
        ocuupationTF.text = occupation
        emailTF.text = email
        phoneTF.text = logphone
        genderTF.text = gender
        picture = UserDefaults.standard.string(forKey: "picture") ?? ""
        profileImage.sd_setImage(with: URL(string: picture!))
        verified = UserDefaults.standard.string(forKey: "verified") ?? ""
    }
    @IBAction func didTapEdit(_ sender: Any) {
        saveView.isHidden = false
        editBtn.isHidden = true
        TFEnable()
    }
    @IBAction func didTapCancel(_ sender: Any) {
        saveView.isHidden = true
        editBtn.isHidden = false
        TFDisable()
    }
    
    @IBAction func didTapImageChange(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image             = info[UIImagePickerController.InfoKey.originalImage]as! UIImage
        let imageData = image.jpegData(compressionQuality: 0.60)?.base64EncodedString() ?? ""
        print(imageData.count)
        //        let imageData:NSData = image.jpegData(compressionQuality: 0.50)! as NSData
        //            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        ImageCompressor.compress(image: image, maxByte: 2000000) { image in
                    guard let compressedImage = image else { return }
            let imageData = compressedImage.jpegData(compressionQuality: 0.60)?.base64EncodedString() ?? ""
            print(imageData.count)
                    // Use compressedImage
                }
            
        fullBase64String = "data:image/jpeg;base64,\(imageData))"
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profileImage.image = image
            callImageChangeAPI()
        }
        else{
            dismiss(animated: true)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    private func callImageChangeAPI(){
        mainView.showLoading()
        let userKey = UserDefaults.standard.string(forKey: "logkey")
        apiManager.profieImageChange(userKey: userKey!, imageUrl: fullBase64String!){ result in
            switch result{
            case .success(let model) :
                self.imageChangeModel = model
                DispatchQueue.main.async {
                    if model.code == "200"{
                        self.mainView.stopLoading()
                        let alert = UIAlertController(title: "Done !", message: "Profile picture is updated", preferredStyle: .actionSheet)
                        self.present(alert, animated: true)
                        let delay = DispatchTime.now() + 5
                        DispatchQueue.main.asyncAfter(deadline: delay){
                            alert.dismiss(animated: true)
                        }
                    }
                }
                UserDefaults.standard.set(model.picture, forKey: "picture")
            case .failure(let error) :
                self.mainView.stopLoading()
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func didTapBackbtn(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func didTapSave(_ sender: Any) {
        TFDisable()
        
        saveView.isHidden = true
        editBtn.isHidden = false
        let userKey = UserDefaults.standard.string(forKey: "logkey")
        guard let fname = nameTF.text else { return}
        guard let userid = userNameTF.text else{return}
        guard let occupation = ocuupationTF.text else{return}
        guard let email = emailTF.text else{return}
        guard let phone = phoneTF.text  else { return}
        guard let gender = genderTF.text else {return}
        if !phone.isValidPhone(phone: phone) {
            phErrorLbl.isHidden = false
            phErrorLbl.text = "* Invalid Phone Number"
            isValidph = false
        }
        else{
            phoneTF.textColor = .label
            phErrorLbl.isHidden = true
            isValidph = true
        }
        if !email.isValidEmail() {
            emailErrorLbl.isHidden = false
            emailErrorLbl.text = "* Invalid Email"
            isValidE = false
        }
        else{
            emailTF.textColor = .label
            emailErrorLbl.isHidden = true
            isValidE = true
        }
        if isValidE, isValidph {
            mainView.showLoading()
            apiManager.profieUpdate(userKey: userKey!, fname: fname, userid: userid, occupation: occupation, email: email, phone: phone, gender: gender) { result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.response = model
                        if model.code == "200"{
                            self.mainView.stopLoading()
                            let alert = UIAlertController(title: "Done!", message: model.message, preferredStyle: .actionSheet)
                            self.present(alert, animated: true)
                            
                            UserDefaults.standard.set(userid, forKey: "userid")
                            UserDefaults.standard.set(occupation, forKey: "occupation")
                            UserDefaults.standard.set(gender, forKey: "gender")
                            let dealy = DispatchTime.now() + 5
                            DispatchQueue.main.asyncAfter(deadline: dealy){
                                alert.dismiss(animated: true)
                            }
                        }
                        else {
                            self.mainView.stopLoading()
                            let alert = UIAlertController(title: "Error!", message: "Something went Wrong", preferredStyle: .actionSheet)
                            self.present(alert, animated: true)
                            let dealy = DispatchTime.now() + 5
                            DispatchQueue.main.asyncAfter(deadline: dealy){
                                alert.dismiss(animated: true)
                            }
                        }
                    }
                case .failure(let error):
                    self.mainView.stopLoading()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
extension ProfileInfoViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTF.text = gender[row]
        genderTF.resignFirstResponder()
    }
}
extension ProfileInfoViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (suggestionModel?.suggestions.count) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
        cell.suggestionBtn.setTitle(suggestionModel?.suggestions[indexPath.row], for: .normal)
        cell.suggestion = {
            self.userNameTF.text = cell.suggestionBtn.currentTitle
            self.lineViewTopCostraints.constant = 8
            self.viewHeightConstraints.constant = 0
        }
        return cell
    }
}
extension ProfileInfoViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        nameTF.resignFirstResponder()
        userNameTF.resignFirstResponder()
        ocuupationTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        phoneTF.resignFirstResponder()
        genderTF.resignFirstResponder()
        
         return true
     }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
         if textField == userNameTF {
            
            lineViewTopCostraints.constant = 48
            viewHeightConstraints.constant = 40
            suggestionModel?.suggestions.removeAll()
            callSuggestionAPI()
            collectionView.reloadData()
            
         } else if textField == ocuupationTF{

             print("heeee")
         }
        
       
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        lineViewTopCostraints.constant = 8
        viewHeightConstraints.constant = 0
        suggestionModel?.suggestions.removeAll()
        collectionView.reloadData()
    }
    
}

