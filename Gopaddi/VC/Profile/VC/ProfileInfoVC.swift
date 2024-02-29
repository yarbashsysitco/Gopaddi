//
//  ProfileInfoVC.swift
//  Gopaddi
//
//  Created by admin on 28/02/24.
//

import UIKit

class ProfileInfoVC: UIViewController {

    @IBOutlet weak var BirthView: UIView!
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var BioView: UIView!
    @IBOutlet weak var NameView: UIView!
    
    var Btntitles = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        borders(view: BirthView, color: .lightGray, width: 2, radius: 5)
        borders(view: LocationView, color: .lightGray, width: 2, radius: 5)
        borders(view: BioView, color: .lightGray, width: 2, radius: 5)
        borders(view: NameView, color: .lightGray, width: 2, radius: 5)

        
    }
    func borders(view: UIView,color: UIColor, width: CGFloat, radius: CGFloat){
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
        view.layer.cornerRadius = radius
    }
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func interestButtonsTap(_ sender: UIButton) {
        guard let Buttons = sender as UIButton? else{return}
        if let Btntaps = sender.titleLabel?.text{
            if !sender.isSelected{
                Btntitles.append(Btntaps)
                print(Btntitles)
            }else{
                if let index = Btntitles.firstIndex(of: Btntaps){
                    Btntitles.remove(at: index)
                    print(Btntitles)
                }
            }

            }
            if !Buttons.isSelected{
                Buttons.isSelected = true
                Buttons.backgroundColor = UIColor.systemBlue
                Buttons.layer.cornerRadius = 25
                
            }else{
                Buttons.isSelected = false
                Buttons.backgroundColor = UIColor.lightGray
                Buttons.layer.cornerRadius = 25
            }
    }
}
