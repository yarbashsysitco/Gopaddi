//
//  PopUpViewController.swift
//  Gopaddi
//
//  Created by jizan k on 03/02/23.
//

import UIKit

class FeedPopUpViewController: UIViewController {
    
    
    var key = String()
    var userKey = String()
    var caption = String()
    var creator = String()
    var imgUrl = String()
    var feedDelete : feedDeleteModel?
    let apiManager = ApiManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
//    func hide(){
//        UIView.animate(withDuration: 0, delay: 0.0, options: .curveEaseOut){
//            self.backView.alpha = 0
//            self.contentView.alpha = 0
//        } completion:{_ in
//            self.dismiss(animated: false)
//            self.removeFromParent()
//        }
//    }
    @IBAction func shareClicked(_ sender: Any) {
        let appName = "Gopaddi"
        let shareAll = [appName , creator , imgUrl]
         let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
         activityViewController.popoverPresentationController?.sourceView = self.view
         self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func deleteClicked(_ sender: Any) {
        print("Delete")
        self.dismiss(animated:false, completion: nil)
        apiManager.feedsDelete(userKey: userKey, key: key){
            result in
            switch result {
            case.success(let model) :
                self.feedDelete = model
                DispatchQueue.main.async { [weak self] in
                    if model.code == "200"
                    {
                        let alert = UIAlertController(title: "Post is Deleted", message: "", preferredStyle: .actionSheet)
                        self?.present(alert, animated: false)
                        let delay = DispatchTime.now() + 4
                        DispatchQueue.main.asyncAfter(deadline: delay){
                          alert.dismiss(animated: true)
                        }
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func editClicked(_ sender: Any) {
        print("Edit")
        let vc = storyboard?.instantiateViewController(withIdentifier: "FeedEditViewController") as? FeedEditViewController
        vc?.userKey = userKey
        vc?.key = key
        vc?.caption = caption
        present(vc!, animated: false)
    }
}
