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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImgView: UIButton!
    @IBOutlet weak var nameLblPost: UILabel!
    @IBOutlet weak var profileImgViewPost: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var ocuupationLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var profileName: UILabel!

    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var profileHistory: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var followersCountLAabel: UILabel!
    @IBOutlet weak var followeslbl: UILabel!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var profileImgView: UIImageView!
    var imageBase64String : String?
    var feilds = ["Timeline","Diary","My applications","Saved"]
    var cellcount = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSetup()
//        textView.delegate = self
//        textView.text = " Type your text Here"
//        postBtn.isHidden = true
//        profileImgView.layer.cornerRadius = profileImgView.frame.width/2
        profileImgViewPost.layer.cornerRadius = profileImgViewPost.frame.width/2
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "ProfileFeildsViewCell", bundle: .main), forCellWithReuseIdentifier: "ProfileFeildsViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageFeed))
        profileImgViewPost.isUserInteractionEnabled = true
        profileImgViewPost.addGestureRecognizer(tapGesture)
//        addImgView.isUserInteractionEnabled = true
//        addImgView.addGestureRecognizer(tapGesture)
        self.tableView.register(UINib.init(nibName: "ProfileCell", bundle: .main), forCellReuseIdentifier: "ProfileCell")
        followeslbl.font = UIFont(name: "Poppins", size: 12)
        followersCountLAabel.font = UIFont(name: "Poppins", size: 12)
        followingLbl.font = UIFont(name: "Poppins", size: 12)
        followingCountLabel.font = UIFont(name: "Poppins", size: 12)
        profileName.font = UIFont(name: "Poppins-SemiBold", size: 18)
        profileNameLbl.font = UIFont(name: "Poppins", size: 14)
        profileHistory.font = UIFont(name: "Poppins", size: 14)
        location.font = UIFont(name: "Poppins", size: 14)
        dobLbl.font = UIFont(name: "Poppins", size: 14)
        memberLabel.font = UIFont(name: "Poppins", size: 14)
        
        print("hello")
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil) 
        }
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
//        profileImgView.sd_setImage(with: URL(string: picture))
//        profileImgViewPost.sd_setImage(with: URL(string: picture))
//        profileName.text = name
//        nameLblPost.text = name
//        ocuupationLbl.text = occupation
//        userNameLbl.text = userName
//        nameLblPost.text = name
        
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
        
        let vc = UIStoryboard(name: "EditMain", bundle: nil).instantiateViewController(withIdentifier: "ProfileInfoVC")as! ProfileInfoVC
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
    
}
extension ProfileVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        postBtn.isHidden = false
        textView.text = ""
    }
}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFeildsViewCell", for: indexPath)as! ProfileFeildsViewCell
        cell.FeildLabel.text = feilds[indexPath.row]
        cell.FeildLabel.font = UIFont(name: "Poppins", size: 14)
        if cellcount == indexPath.row{
            cell.bottomView.backgroundColor = UIColor.systemBlue
        }else{
            cell.bottomView.backgroundColor = UIColor.white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat
        if indexPath.row == 0{
            width = 100
        }else if indexPath.row == 1{
            width = 80
        }else if indexPath.row == 2{
            width = 140
        }else{
            width = 80
        }
        return CGSize(width: width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellcount = indexPath.row
        collectionView.reloadData()
    }
}
