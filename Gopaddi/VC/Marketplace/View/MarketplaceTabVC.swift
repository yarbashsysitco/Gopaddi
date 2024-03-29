//
//  MarketplaceVC.swift
//  Gopaddi
//
//  Created by admin on 28/12/22.
//

import UIKit

class MarketplaceTabVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
var images = ["ActivitiesMarket","HotelsMarket","FlightsMarket","VisaMarket","ImmigrationMarket","MedicalMarket","VacationMarket"]
    var Names = ["Activities","Hotels","Flights","Visa","Immigration","Medical","Vacation Packages"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "TopViewCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "TopViewCollectionViewCell")
        self.tableView.register(UINib.init(nibName: "AccountsMarketTBCell", bundle: nil), forCellReuseIdentifier: "AccountsMarketTBCell")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopViewCollectionViewCell", for: indexPath)as! TopViewCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.size.width
        return CGSize(width: w, height: 142)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsMarketTBCell", for: indexPath)as! AccountsMarketTBCell
        cell.accountName.text = Names[indexPath.row]
        cell.accountImgs.image = UIImage(named: images[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard(name: "MarketplaceMain", bundle: nil).instantiateViewController(withIdentifier: "ActivityMainViewController") as! ActivityMainViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case 1:
            print("1")
        case 2:
            print("2")
        case 3:
            print("3")
        case 4:
            print("4")
        case 5:
            print("5")
        case 6:
            print("6")
        default:
            break
        }
    }
}



