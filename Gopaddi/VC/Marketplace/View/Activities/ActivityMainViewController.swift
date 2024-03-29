//
//  ActivityMainViewController.swift
//  Gopaddi
//
//  Created by jizan k on 27/03/24.
//

import UIKit

class ActivityMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,fromdate,todate,ageDataPass{
    func ages(ageData: [String]) {
        childCount = ageData
        print(childCount)
        reloadInputViews()
    }
    
    func Todates(date: String) {
        toDateLbl.text = date
        toDateLbl.textColor = .black
        reloadInputViews()
    }
    
    func dates(date: String) {
        fromdateLbl.text = date
        fromdateLbl.textColor = .black
        reloadInputViews()
    }
    
    var counts = 0
    var adultCount = 0
    var cellcount = [Int]()
    var childCount = [String]()
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromdateLbl: UILabel!
    @IBOutlet weak var childCountLbl: UILabel!
    @IBOutlet weak var tbHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionTopView: UIView!
    @IBOutlet weak var adultCountLbl: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.tbHeight.constant = 0
        tableview.register(UINib.init(nibName: "ChildCountTableViewCell", bundle: nil), forCellReuseIdentifier: "ChildCountTableViewCell")
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib.init(nibName: "ChooseActivityCell", bundle: nil),forCellWithReuseIdentifier: "ChooseActivityCell")
        collectionTopView.layer.maskedCorners = [.layerMinXMinYCorner ,.layerMaxXMinYCorner]
        collectionTopView.layer.cornerRadius = 4
        collection.layer.cornerRadius = 4
        collection.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
      
    
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func adultIncreaseBtn(_ sender: UIButton) {
        if adultCount < 9 {
            adultCount += 1
            updateAdultCount()
        }
    }
    
    @IBAction func adultDecreaseBtn(_ sender: UIButton) {
        if adultCount > 1 {
            adultCount -= 1
            updateAdultCount()
        }
    }
    
    
    @IBAction func childIncreseBtn(_ sender: UIButton) {
        if counts < 9 {
                counts += 1
                cellcount.append(counts)
                print(cellcount)
                updateCountLabel()
                adjustTableViewHeight()
                tableview.reloadData()
            }
    }
    @IBAction func childDecreasebtn(_ sender: UIButton) {
        if counts > 0 {
            counts -= 1
            updateCountLabel()
            adjustminusTableViewHeight()
            tableview.reloadData()
        }
    }
        func updateAdultCount(){
            adultCountLbl.text = "\(adultCount)"
        }
        
    func updateCountLabel() {
        childCountLbl.text = "\(counts)"
    }
    
    func adjustTableViewHeight() {
            tbHeight.constant = CGFloat(cellcount.count * 100)
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    func adjustminusTableViewHeight() {
        if !cellcount.isEmpty {
                cellcount.removeLast() // Remove the last count from the array
                
                // Remove the last cell from the table view
                let indexPath = IndexPath(row: cellcount.count, section: 0)
                tableview.beginUpdates()
                tableview.deleteRows(at: [indexPath], with: .automatic)
                tableview.endUpdates()
                
                updateCountLabel()
                adjustTableViewHeightIfNeeded()
            }
        }
    func adjustTableViewHeightIfNeeded() {
        let desiredHeight = CGFloat(cellcount.count * 100)
        if tbHeight.constant > desiredHeight {
            tbHeight.constant = desiredHeight
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func fromDateBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MarketplaceMain", bundle: nil).instantiateViewController(withIdentifier: "FromCalendarVC")as! FromCalendarVC
        vc.sendDeligate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func toDateBtn(_ sender: UIButton) {
            let vc = UIStoryboard(name: "MarketplaceMain", bundle: nil).instantiateViewController(withIdentifier: "ToCalendarVC")as! ToCalendarVC
             vc.sendtoDateDeligate = self
            self.present(vc, animated: true)
    }
    
    @IBAction func destinationSelectBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MarketplaceMain", bundle: nil).instantiateViewController(withIdentifier: "LocationVC")as! LocationVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func searchBtnClick(_ sender: UIButton) {
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellcount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCountTableViewCell", for: indexPath)as! ChildCountTableViewCell
        if indexPath.row < childCount.count {
                
                cell.ageShowLbl.text = childCount[indexPath.row]
            } else {
                
                cell.ageShowLbl.text = "0"
            }
        print(childCount)
        cell.ageCountBtn = { [weak self] in
            guard let self = self else { return }
            
            let vc = UIStoryboard(name: "MarketplaceMain", bundle: nil).instantiateViewController(withIdentifier: "AgeSelectionVC")as! AgeSelectionVC
            vc.ageDelegate = self
            self.present(vc, animated: true)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ChooseActivityCell", for: indexPath)as! ChooseActivityCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collection.frame.size.width/2
        return CGSize(width: w, height: 230)
    }
    
    
}
