//
//  ProfileInfoVC.swift
//  Gopaddi
//
//  Created by admin on 28/02/24.
//

import UIKit

class ProfileInfoVC: UIViewController ,SendingData{
    func SaveData(Title: String, Image: UIImage?) {
        whouseBtn.setTitle(Title, for: .normal)
    }
    

    @IBOutlet weak var whouseBtn: UIButton!
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
                Buttons.layer.backgroundColor = UIColor.white.cgColor
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
                Buttons.layer.backgroundColor  =  #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
                Buttons.layer.cornerRadius = 25
                Buttons.setTitleColor(UIColor.white, for: .selected)

            }else{
                Buttons.isSelected = false
                Buttons.layer.backgroundColor =  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
                Buttons.titleLabel?.textColor
                Buttons.layer.cornerRadius = 25
            }
    }
    
    
    @IBAction func birthdayBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectCalendarPopUp") as? SelectCalendarPopUp
        //vc?.modalPresentationStyle = .fullScreen
        print("hello")
        self.present(vc!, animated: true)
    }
    
    @IBAction func whocanTapButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WhocanSeeProfileViewController") as! WhocanSeeProfileViewController
        vc.sendDeligate = self
        self.present(vc, animated: true)
    }
    
}
