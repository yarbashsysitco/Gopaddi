//
//  ViewController.swift
//  scroll
//
//  Created by Apple on 10/03/24.
//

import UIKit

class OnboardingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let utilityF = UtilitiesFunctions()
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet weak var collection: UICollectionView!
    
    
    var currentpage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib.init(nibName: "OnboardingFirstCell", bundle: nil),forCellWithReuseIdentifier: "OnboardingFirstCell")
        collection.register(UINib.init(nibName: "OnboardingSecondCell", bundle: nil),forCellWithReuseIdentifier: "OnboardingSecondCell")
        collection.register(UINib.init(nibName: "OnboardingThirdCell", bundle: nil),forCellWithReuseIdentifier: "OnboardingThirdCell")
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pagecontrol.currentPage = Int(x / view.frame.width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingFirstCell", for: indexPath)as! OnboardingFirstCell
            return cell
            
        }else if indexPath.section == 1 {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingSecondCell", for: indexPath)as! OnboardingSecondCell
            return cell
        }else{
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingThirdCell", for: indexPath)as! OnboardingThirdCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return CGSize(width: screenWidth, height: screenHeight)
    }


    
//    @IBAction func didTapPassButton(_ sender: UIButton) {
//        if currentpage < pageControl.numberOfPages{
//            currentpage += 1
//            updatecontroll()
//        }
//    }
    
    func updatecontroll(){
        pagecontrol.currentPage = currentpage
    }
    @IBAction func createButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @IBAction func loginButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")as! SignInVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

