//
//  SideMenuViewController.swift
//  Gopaddi
//
//  Created by jizan k on 15/03/24.
//

import UIKit

class SideMenuViewController: UIViewController {
   
    @IBOutlet weak var addedUserImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        gesture()
        self.viewHeight.constant = 0
        self.addedUserImg.isHidden = true
    }
    func gesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainViewGesture))
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func mainViewGesture(){
        self.dismiss(animated: true)
    }
    
    @IBAction func dropDownBtn(_ sender: UIButton) {
        if viewHeight.constant == 0 {
            sender.setImage(UIImage(named: "TopArrow"), for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.viewHeight.constant = 110
                self.addedUserImg.isHidden = false
                self.view.layoutIfNeeded()
            }
        }else{
            sender.setImage(UIImage(named: "BottomArrow"), for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.viewHeight.constant = 0
                self.addedUserImg.isHidden = true
                self.view.layoutIfNeeded()
            }
            
        }
    }
        @IBAction func profileTapBtn(_ sender: UIButton) {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC")as! ProfileVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    
}
