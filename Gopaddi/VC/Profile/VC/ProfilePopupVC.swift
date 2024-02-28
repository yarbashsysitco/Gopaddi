//
//  ProfilePopupVC.swift
//  Gopaddi
//
//  Created by jizan k on 11/01/23.
//

import UIKit

class ProfilePopupVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var backView: UIView!
    
    @IBOutlet weak var interestBtn: UIButton!
    @IBOutlet weak var userActivityBtn: UIButton!
    @IBOutlet weak var badgeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    func configView(){
        self.view.backgroundColor = .clear
        backView.backgroundColor = .clear
        self.contentView.alpha = 2
        self.contentView.layer.cornerRadius = 10
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == backView {
            dismiss(animated: true, completion: nil)
        }
    }
    func appear(sender : UIViewController){
        sender.present(self, animated: false)
        //                self.show()
    }
    func show(){
        UIView.animate(withDuration: 1, delay: 0.1){
        }
    }
    func hide(){
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut){
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion:{_ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    @IBAction func aboutBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as? AboutViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func badgeBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BaggeViewController") as? BaggeViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func userActivityBtnClicked(_ sender: Any) {
    }
    
    @IBAction func interseBtnClicked(_ sender: Any) {
    }
}
