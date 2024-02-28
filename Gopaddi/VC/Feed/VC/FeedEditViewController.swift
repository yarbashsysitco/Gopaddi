//
//  FeedEditViewController.swift
//  Gopaddi
//
//  Created by jizan k on 13/02/23.
//

import UIKit
import SDWebImage

class FeedEditViewController: UIViewController {
    let apiManager = ApiManager()
    var feedEdit : feedEditModel?
    var userKey = String()
    var key = String()
    var caption = String()
    var imgUrl = String()
    
    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var messageTV: TextView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = URL(string: imgUrl)
//        imgView.sd_setImage(with: url)
        messageTV.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        messageTV.text = caption
    }
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: false)
    }
    
    @IBAction func postClicked(_ sender: Any) {
        guard let message = messageTV.text else {return}
        apiManager.feedsEdit(userKey: userKey, key: key, caption: message, file: imgUrl){
            result in
            switch result {
            case.success(let model) :
                DispatchQueue.main.async {
                    self.feedEdit = model
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
                    vc?.modalPresentationStyle = .fullScreen
                    self.present(vc!, animated: true)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }   
    }
}

