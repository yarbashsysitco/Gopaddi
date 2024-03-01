//
//  WhocanSeeProfileViewController.swift
//  Gopaddi
//
//  Created by jizan k on 29/02/24.
//

import UIKit

protocol SendingData{
    func SaveData(Title: String, Image: UIImage?)
}
class WhocanSeeProfileViewController: UIViewController {

   
    var sendDeligate: SendingData?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SelectionButton(_ sender: UIButton) {
        let Btntitles = sender.titleLabel?.text ?? ""
        let Btnimage = sender.imageView?.image
        sendDeligate?.SaveData(Title: Btntitles, Image: Btnimage)
        print(Btntitles)
        self.dismiss(animated: true)
    }
    
    

}
