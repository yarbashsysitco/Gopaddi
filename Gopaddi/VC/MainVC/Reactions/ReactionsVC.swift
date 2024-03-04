//
//  ReactionsVC.swift
//  Gopaddi
//
//  Created by admin on 18/01/24.
//

import UIKit

class ReactionsVC: UIViewController {
    
    @IBOutlet weak var reactionImage: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!

    @IBOutlet weak var uiview0: UIView!
    
    @IBOutlet weak var uiviw1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        ReactionTap()
    }
    func ReactionTap(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TappingImage))
        reactionImage.isUserInteractionEnabled = true
        reactionImage.addGestureRecognizer(tapGesture)
    }
    @objc func TappingImage(){
        let vc = UIStoryboard(name: "ReactionMain", bundle: nil).instantiateViewController(withIdentifier: "ReactionMainViewController")as! ReactionMainViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func setupUI() {
        uiview0.layer.cornerRadius = 5
        uiviw1.layer.cornerRadius = 25
        
//        // Add a tap gesture to dismiss the keyboard when tapping outside the text field
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        contentView.addGestureRecognizer(tapGesture)
//        
        // Customize the appearance of the view
       // configView()
    }
    
//    func configureView() {
//        self.view.backgroundColor = .black.withAlphaComponent(0.6)
//        self.contentView.alpha = 2
//        self.contentView.layer.cornerRadius = 10
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
   
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

   
    @IBAction func backbtns(_ sender: Any) {
        self.dismiss(animated: true)

    }
    
}
