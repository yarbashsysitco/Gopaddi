//
//  TravelStyleVC.swift
//  Gopaddisubdemo
//
//  Created by Apple on 21/03/24.
//

import UIKit

class TravelStyleVC: UIViewController {
   
    var WhiteImages = ["Study 1","Pill 1","Immigration 1","Wine 1","Visa","Flights","Hotel 1","Activities 1","Training","Seminar","Event","Conference","HouseWhite"]
    var BlackImages = ["StudyBlack","pill","immigration","Wine","VisaBlack","flight 1","Hotel 2","Activities","TrainingBlack","SeminarBlack","EventBlack","conferenceBlack","House"]
    var Btntitles = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func vectorBtnTap(_ sender: UIButton) {
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
            Buttons.layer.backgroundColor  =    #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
            Buttons.layer.cornerRadius = 25
            Buttons.tintColor = UIColor.white
            Buttons.setImage(UIImage(named: WhiteImages[sender.tag]), for: .normal)
            
        }else{
            Buttons.isSelected = false
            Buttons.layer.backgroundColor =   #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            Buttons.titleLabel?.textColor
            Buttons.layer.cornerRadius = 25
            Buttons.tintColor = UIColor.black
            Buttons.setImage(UIImage(named: BlackImages[sender.tag]), for: .normal)
        }
        
    }
    
    @IBAction func NextBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContainersGopaddiVC")as! ContainersGopaddiVC
        vc.datas = 2
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
}
