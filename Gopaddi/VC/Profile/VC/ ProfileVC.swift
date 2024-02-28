//
//  SSViewController.swift
//  Gopaddi
//
//  Created by admin on 28/12/22.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var utility = UtilitiesFunctions()
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImgView: UIButton!
    @IBOutlet weak var nameLblPost: UILabel!
    @IBOutlet weak var profileImgViewPost: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var ocuupationLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var profileName: UILabel!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var profileImgView: UIImageView!
    var imageBase64String : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSetup()
        textView.delegate = self
        textView.text = " Type your text Here"
        postBtn.isHidden = true
        profileImgView.layer.cornerRadius = profileImgView.frame.width/2
        profileImgViewPost.layer.cornerRadius = profileImgViewPost.frame.width/2
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageFeed))
        addImgView.isUserInteractionEnabled = true
        addImgView.addGestureRecognizer(tapGesture)
        self.tableView.register(UINib.init(nibName: "ProfileCell", bundle: .main), forCellReuseIdentifier: "ProfileCell")
    }
    @objc private func didTapImageFeed(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageData = image.jpegData(compressionQuality: 1)
        let base64 = imageData?.base64EncodedString(options: .lineLength64Characters)
        imageBase64String = "data:@file/jpeg;base64,\(String(describing: base64))"
        picker.dismiss(animated: false)
    }
    private func profileSetup(){
        view.showLoading()
        let name = UserDefaults.standard.string(forKey: "logname") ?? ""
        let occupation = UserDefaults.standard.string(forKey: "occupation") ?? ""
        let userName = UserDefaults.standard.string(forKey: "username") ?? ""
        let picture = UserDefaults.standard.string(forKey: "picture") ?? ""
        profileImgView.sd_setImage(with: URL(string: picture))
        profileImgViewPost.sd_setImage(with: URL(string: picture))
        profileName.text = name
        nameLblPost.text = name
        ocuupationLbl.text = occupation
        userNameLbl.text = userName
        nameLblPost.text = name
        
        view.stopLoading()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 660
    }
    @IBAction func profilePopupBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopupVC") as? ProfilePopupVC
        self.present(vc!, animated: false)
    }
    @IBAction func didTapEditProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileInfoViewController") as! ProfileInfoViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func didTapPostBtn(_ sender: Any) {
    }
    @IBAction func settingsBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
extension ProfileVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        postBtn.isHidden = false
        textView.text = ""
    }
}
