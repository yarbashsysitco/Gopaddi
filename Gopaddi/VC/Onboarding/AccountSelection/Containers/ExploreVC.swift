//
//  ExploreVC.swift
//  Gopaddisubdemo
//
//  Created by Apple on 21/03/24.
//

import UIKit

class ExploreVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self
        self.collection.register(UINib.init(nibName: "ExploreCollectionVC", bundle: nil),forCellWithReuseIdentifier: "ExploreCollectionVC")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionVC", for: indexPath)as! ExploreCollectionVC
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collection.frame.size.width/2
        return CGSize(width: w, height: 215)
    }

    
    @IBAction func SubmitBtnTap(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC")as! SignInVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
