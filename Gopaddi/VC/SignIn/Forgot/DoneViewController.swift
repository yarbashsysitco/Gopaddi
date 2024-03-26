//
//  DoneViewController.swift
//  Gopaddi
//
//  Created by jizan k on 07/03/24.
//

import UIKit

class DoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logBtnTap(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC")as! SignInVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
