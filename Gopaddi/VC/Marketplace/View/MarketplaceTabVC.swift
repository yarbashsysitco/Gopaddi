//
//  MarketplaceVC.swift
//  Gopaddi
//
//  Created by admin on 28/12/22.
//

import UIKit

class MarketplaceTabVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func didTapActivity(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ActivityViewController") as! ActivityViewController
//        let nav = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @IBAction func didTapFlight(_ sender: Any) {
//        let vc = FlightViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: false)
//        
        
        let str = UIStoryboard(name: "Main", bundle: nil)
        let vc = str.instantiateViewController(identifier: "FlightConfirmVC")as! FlightConfirmVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @IBAction func didTapHotels(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HotelViewController") as! HotelViewController
//        let nav = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

extension MarketplaceTabVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marketPlace", for: indexPath)
        cell.backgroundColor = .systemGray6
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
    }
}



