//
//  NetworkErrorViewController.swift
//  Gopaddi
//
//  Created by jizan k on 17/12/22.
//

import UIKit

class NetworkErrorViewController: UIViewController
{
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    
//        @IBOutlet weak var tryAgainButton: UIButton!
//        init(){
//            super.init(nibName: "CustomAlertViewController", bundle: Bundle(for: CustomAlertViewController.self))
//            self.modalPresentationStyle = .overFullScreen
//        }
//
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
        override func viewDidLoad() {
            super.viewDidLoad()
            configView()
        }
        func configView(){
            self.view.backgroundColor = .clear
            self.backView.backgroundColor   = .black.withAlphaComponent(0.6)
            self.backView.alpha = 0
            self.contentView.alpha = 1
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
    //    @IBAction func tryAgainButtonClicked(_ sender: Any) {
    ////        hide()
    //    }
    
    }
//
//    let alertViewDrayColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setup()
//        animateView()
//    }
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        view.layoutIfNeeded()
//    }
//    func appear(sender : UIViewController){
//            sender.present(self, animated: false)
//
//        }
//    func setup(){
//        contentView.layer.cornerRadius = 15
//        self.backView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//    }
//    func animateView(){
//        contentView.alpha = 0
//        self.contentView.frame.origin.y = self.contentView.frame.origin.y + 0
//        UIView.animate(withDuration: 0.0, animations: {  () -> Void in
//            self.contentView.alpha = 1.0;
//            self.contentView.frame.origin.y = self.contentView.frame.origin.y - 0 })
//    }
//}
