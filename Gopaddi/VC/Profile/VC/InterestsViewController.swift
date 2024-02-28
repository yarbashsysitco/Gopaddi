//
//  InterestsViewController.swift
//  Gopaddi
//
//  Created by jizan k on 20/01/23.
//

import UIKit

class InterestsViewController: UIViewController {
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    var interestList : [String] = []
    var userKey : String?
    let apiManager = ApiManager()
    var subscriptionModel : UserSubscription?
    var interestModel : InterestModel?
    var selectedIndex = [Int]()
    var selectedInterest = [String]()
    let personal = UserDefaults.standard.string(forKey: "personal")
    override func viewDidLoad() {
        super.viewDidLoad()
        proceedButton.isEnabled = false
        proceedButton.alpha = 0.8
        collectionView.delegate = self
        collectionView.dataSource = self
        userKey = UserDefaults.standard.string(forKey: "logkey")
        
    }
    @IBAction func selecetdInterests(sender: AnyObject){
        guard let interestButton = sender as? UIButton else{
            return
        }
        switch interestButton.tag {
        case 0 : print("Travel")
            interestButton.backgroundColor = .systemBlue
        case 1 : print("Vacations")
            interestButton.backgroundColor = .systemBlue
        case 2 : print("Hotels")
            if !interestButton.isSelected {
                interestButton.isSelected = true
                interestList.append((interestButton.titleLabel?.text) ?? "Hotels")
                interestButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
                interestButton.backgroundColor = UIColor.blue
            }
            else {
                interestButton.isSelected = false
                if let index = interestList.firstIndex(of: "Hotels") {
                    interestList.remove(at: index)
                }
                
                interestButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
                interestButton.backgroundColor = UIColor.white
            }
            print(interestList)
        case 3 : print("Activities")
            if !interestButton.isSelected {
                interestButton.isSelected = true
                interestList.append(interestButton.titleLabel?.text ?? "Activities")
                interestButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
                interestButton.backgroundColor = UIColor.blue
            }
            else {
                interestButton.isSelected = false
                if let index = interestList.firstIndex(of: "Activities") {
                    interestList.remove(at: index)
                }
                interestButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
                interestButton.backgroundColor = UIColor.white
            }
            print(interestList)
        case 4 : print("Medical")
        case 5 : print("Immigration")
        case 6 : print("Study")
        case 7 : print("Flights")
            
        default:
            print("Default")
        }
    }
    @IBAction func proceedBtnClicked(_ sender: Any) {
        
        apiManager.intersetDetails(userKey: userKey!, interests: selectedInterest) { result in
            switch result {
            case .success(let model) :
                self.interestModel = model
//                self.callApi()
                DispatchQueue.main.async {
                    if model.code == "200" {
                        UserDefaults.standard.set("false", forKey: "isInterest")
                        UserDefaults.standard.set(true, forKey: "isInterest")
                        let alert = UIAlertController(title: "Done !", message: "Interests are Taken", preferredStyle: .alert)
                        let alertButton = UIAlertAction(title: "OK", style: .default) { _ in
//                            if let personal = self.personal, personal == "true" {
//                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonalDetailsViewController") as? PersonalDetailsViewController
//                                self.present(vc!, animated: true)
//                            }else{
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
                                vc?.modalPresentationStyle = .fullScreen
                                self.present(vc!, animated: true)
//                            }
                   
                        }
                        
                        alert.addAction(alertButton)
                        self.present(alert, animated: true)
                    }
                    else {
                        let alert = UIAlertController(title: "Error", message: self.interestModel?.message, preferredStyle: .alert)
                        let AlertOkButton = UIAlertAction(title: "Ok", style: .default) { _ in
                            
                        }
                        alert.addAction(AlertOkButton)
                        self.present(alert, animated: true)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func callApi(){
        let userKey = UserDefaults.standard.string(forKey: "gkey") ?? (UserDefaults.standard.string(forKey: "logkey") ?? UserDefaults.standard.string(forKey: GlobalConstants.userLoginKeys.key))
        apiManager.subscription(userKey: userKey!) { result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    self.subscriptionModel = model
                    let uname = self.subscriptionModel?.personal?[0].uname
               
                    if let personal = model.personal?[0].uname, !personal.isEmpty {
                        print("setvalu")
                        UserDefaults.standard.set("false", forKey: "isInterest")
                    } else {
                        print("Notvalu")
                        UserDefaults.standard.set("true", forKey: "isInterest")
                    }

                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func didTapBack(_ sender: Any) {
        dismiss(animated: false)
    }
    @IBAction func skipBtnClicked(_ sender: Any) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController
        vc?.modalPresentationStyle = .fullScreen
//        vc?.userKey = userKey!
        self.present(vc!, animated: true)
    }
}
extension InterestsViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestsCell", for: indexPath) as! InterestCollectionViewCell
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        if selectedIndex.contains(indexPath.item) {
            cell.backgroundColor = UIColor.systemBlue
            cell.imaageView.backgroundColor = .systemBlue
            cell.imaageView.tintColor = .systemBlue
        }
        else {
            
                cell.backgroundColor = UIColor.systemGray6
                cell.imaageView.backgroundColor = .systemGray6
            cell.imaageView.tintColor = .label
            
        }
        cell.setUp(with: interestData[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath)
        let currentCell = collectionView.cellForItem(at: indexPath) as! InterestCollectionViewCell
        currentCell.imaageView.image = currentCell.imaageView.image?.withRenderingMode(.alwaysTemplate)
        currentCell.imaageView.backgroundColor = .systemBlue
        cell?.backgroundColor = UIColor.systemBlue
        if !selectedIndex.contains(indexPath.item){
            selectedIndex.append(indexPath.item)
            selectedInterest.append(interestData[indexPath.row].title)
        }
        else{
            if let currIndex = selectedIndex.firstIndex(of: indexPath.item) {
                selectedIndex.remove(at: currIndex)
                cell?.backgroundColor = .systemGray6
                print(interestData[indexPath.row].title)
            }
            if let currIndex = selectedInterest.firstIndex(of: interestData[indexPath.row].title){
            selectedInterest.remove(at: currIndex)
            }
        }
        if selectedInterest.count > 2 {
            proceedButton.isEnabled = true
            proceedButton.alpha = 1
        }else{
            proceedButton.isEnabled = false
            proceedButton.alpha = 0.8
        }
    }
}
extension InterestsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2 - 40, height: 75)
    }
}
