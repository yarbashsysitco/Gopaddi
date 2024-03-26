//
//  GopalProfileSetupVC.swift
//  Gopaddisubdemo
//
//  Created by Apple on 20/03/24.
//

import UIKit


class GopalProfileSetupVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
       accessControl()
    }
    

    @IBAction func NextBtnTap(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContainersGopaddiVC")as! ContainersGopaddiVC
        vc.datas = 1
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    func accessControl(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(AccessMethod))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tap)
    }
    
    @objc func AccessMethod(){
        let vc = UIStoryboard(name: "OnboardingAccountMain", bundle: nil).instantiateViewController(withIdentifier: "CameraAccessVC")as! CameraAccessVC
        self.present(vc, animated: true)
    }
    
    
}
