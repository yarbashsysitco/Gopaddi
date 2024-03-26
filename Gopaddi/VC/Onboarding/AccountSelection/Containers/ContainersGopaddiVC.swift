//
//  ContainersGopaddiVC.swift
//  Gopaddisubdemo
//
//  Created by Apple on 21/03/24.
//

import UIKit

class ContainersGopaddiVC: UIViewController{

    
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var travelView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var exploreText: UILabel!
    @IBOutlet weak var travelText: UILabel!
    @IBOutlet weak var profileText: UILabel!
    var datas = Int()
    @IBOutlet weak var exploreContainer: UIView!
    @IBOutlet weak var travelContainer: UIView!
    @IBOutlet weak var profileContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.bringSubviewToFront(profileContainer)
       
        
        if datas == 1{
            self.view.bringSubviewToFront(travelContainer)
            profileText.textColor = .systemBlue
            profileView.backgroundColor = .systemBlue
            travelText.textColor = .black
            travelText.font = .boldSystemFont(ofSize: 12)
            travelView.backgroundColor = .black
            
        }else if datas == 2{
            self.view.bringSubviewToFront(exploreContainer)
            profileText.textColor = .systemBlue
            profileView.backgroundColor = .systemBlue
            travelText.textColor = .systemBlue
            travelText.font = .boldSystemFont(ofSize: 12)
            travelView.backgroundColor = .systemBlue
            exploreText.textColor = .black
            exploreText.font = .boldSystemFont(ofSize: 12)
            exploreView.backgroundColor = .black
            
        }else{
            self.view.bringSubviewToFront(profileContainer)
        }
        
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
