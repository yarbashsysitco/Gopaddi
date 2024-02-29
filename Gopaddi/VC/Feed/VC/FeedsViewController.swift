//
//  FeedsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 31/01/23.
//

import UIKit

class FeedsViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate {
    var imagePicker = UIImagePickerController()
    var imageBase64String : String?
    var userKey = String()
    let apiManager = ApiManager()
    var feedsCreateModel : FeedsCreateModel?
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var cencelBtn: UIButton!
    
    @IBOutlet weak var postBtn: UIButton!
    
    @IBOutlet weak var textViewMessage: TextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var removeImageBtn: UIButton!
    
    @IBOutlet weak var uploadBtns: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeImageBtn.isHidden = true
        profileSetup()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadImageBtnClicked(tapGestureRecognizer:)))
//            imageView.isUserInteractionEnabled = true
        uploadBtns.addGestureRecognizer(tapGestureRecognizer)
            textViewMessage.delegate = self

    }
    
    @IBAction func UploadImageBtn(_ sender: Any) {
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        postBtn.isEnabled = !text.isEmpty
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            // Compress the image to reduce its size
//            let compressedImage = compressImage(image, toMaxSize: 1.0) // 1.0 MB
//
//            // Convert the compressed image to base64
//            if let imageData = compressedImage.jpegData(compressionQuality: 1.0) {
//                let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
//                imageBase64String = "data:image/jpeg;base64,\(strBase64)"
//
//                // Set the image view with the compressed image
//                imageView.image = compressedImage
//            }
//        }
//
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func compressImage(_ image: UIImage, toMaxSize maxSizeMB: CGFloat) -> UIImage {
//        let maxSizeBytes = maxSizeMB * 1024 * 1024 // Convert MB to bytes
//        var compression: CGFloat = 1.0
//        var imageData = image.jpegData(compressionQuality: compression)!
//
//        while CGFloat(imageData.count) > maxSizeBytes && compression > 0.1 {
//            compression -= 0.1
//            imageData = image.jpegData(compressionQuality: compression)!
//        }
//
//        return UIImage(data: imageData)!
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            // Compress the image to reduce its size to 1024 KB (1 MB)
//            let maxSizeKB: CGFloat = 1024.0
//            let compressedImage = compressImage(image, toMaxSizeKB: maxSizeKB)
//
//            // Convert the compressed image to base64
//            if let imageData = compressedImage.jpegData(compressionQuality: 1.0) {
//                let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
//                imageBase64String = "data:image/jpeg;base64,\(strBase64)"
//
//                // Set the image view with the compressed image
//                imageView.image = compressedImage
//            }
//        }
//
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func removeImageBtns(_ sender: Any) {
        imageView.image = nil
        imageBase64String = nil // Optionally reset the base64 string if needed
        removeImageBtn.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Call a function to compress the picked image
            if let compressedImageData = compressImage(image: pickedImage, maxSizeKB: 1023) {
                if let compressedImage = UIImage(data: compressedImageData) {
                    // Set the image view with the compressed image
                    imageView.image = compressedImage
                    removeImageBtn.isHidden = false


                    // Optionally, convert the compressedImageData to base64
                    let strBase64 = compressedImageData.base64EncodedString(options: .lineLength64Characters)
                    imageBase64String = "data:image/jpeg;base64,\(strBase64)"
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
          // Remove placeholder when the user starts typing
          if textViewMessage.text == "Share your travel thoughts?" {
              textViewMessage.text = ""
              textViewMessage.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)// Change to the desired text color
          }
      }
    
    private func profileSetup(){
        let name = UserDefaults.standard.string(forKey: "logname") ?? ""
        let userNames = UserDefaults.standard.string(forKey: "username") ?? ""
        let picture = UserDefaults.standard.string(forKey: "picture") ?? ""
        userImage.sd_setImage(with: URL(string: picture))
        userImage.sd_setImage(with: URL(string: picture))
        userName.text = name
        userImage.layer.cornerRadius = userImage.frame.width/2

//        userName.text = userNames
    }
    
    


    func compressImage(image: UIImage, maxSizeKB: Int) -> Data? {
          var compressionQuality: CGFloat = 1.0 // Initial compression quality
          var imageData = image.jpegData(compressionQuality: compressionQuality)
          
          while let data = imageData, data.count > maxSizeKB * 1024, compressionQuality > 0.1 {
              compressionQuality -= 0.1
              imageData = image.jpegData(compressionQuality: compressionQuality)
          }
          
          return imageData
      }


    @objc func uploadImageBtnClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)

        }
    }
    
    @IBAction func postBtnClicked(_ sender: Any) {
            guard let postImage = imageBase64String else { return }
            guard let postMessage = self.textViewMessage.text else { return }
           
            if postImage.isEmpty {
                imageView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                imageView.layer.borderColor = UIColor.blue.cgColor
            }
        view.showLoading()
        textViewMessage.isUserInteractionEnabled = false
        imageView.isUserInteractionEnabled = false
        cencelBtn.isEnabled = false
        postBtn.isEnabled = false
        apiManager.feedsPosts(userKey : userKey , caption : postMessage , file : postImage) { result in
                switch result {
                case.success(let model):
                    self.feedsCreateModel = model
                    DispatchQueue.main.async {[weak self] in
                        if model.code == "200" {
                            self?.textViewMessage.isUserInteractionEnabled = true
                            self?.imageView.isUserInteractionEnabled = true
                            self?.cencelBtn.isEnabled = true
                            self?.postBtn.isEnabled = true
                            self?.view.stopLoading()
                            let alert = UIAlertController(title:"Done!", message: "Feeds Created", preferredStyle: .alert)
                            let alertButton = UIAlertAction(title: "OK", style: .default) { _ in
                                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
                                vc?.modalPresentationStyle = .fullScreen
                                self?.present(vc!, animated: true)
                            }
                            alert.addAction(alertButton)
                            self?.present(alert, animated: true)
                        } else {
                            self?.textViewMessage.isUserInteractionEnabled = true
                            self?.imageView.isUserInteractionEnabled = true
                            self?.cencelBtn.isEnabled = true
                            self?.postBtn.isEnabled = true
                            self?.view.stopLoading()
                            let alertcontrollert = UIAlertController(title: "Error" , message: self?.feedsCreateModel?.message ?? "Something went wrong!", preferredStyle: .alert)
                            let alertButoon = UIAlertAction(title: "Ok", style: .default) { _ in
                            }
                        }
                    }
                case.failure(let error):
                    self.view.stopLoading()
                    print(error.localizedDescription)
                }
            }
        }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func PublicBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseAudiencePopUpVC") as? ChooseAudiencePopUpVC
        //vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    
}
