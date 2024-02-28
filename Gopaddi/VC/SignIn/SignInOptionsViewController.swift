//
//  SignInOptionsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 10/04/23.
//

import UIKit

class SignInOptionsViewController: UIViewController {
    var user = String()
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
         // Add tap gesture recognizer to the backView
//         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backViewTapped))
//         backView.addGestureRecognizer(tapGestureRecognizer)
     }
    
    func configView(){
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        self.contentView.alpha = 2
        self.contentView.layer.cornerRadius = 10
    }
    func appear(sender : UIViewController){
        sender.present(self, animated: false)
        self.show()
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
    
//
//     @objc func backViewTapped() {
//         // Dismiss the contentView when the backView is tapped
//         self.contentView.removeFromSuperview()
//     }
    @IBAction func didTapButton(_ sender: Any) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
        }
    
    
    @IBAction func BackBtn(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    }

