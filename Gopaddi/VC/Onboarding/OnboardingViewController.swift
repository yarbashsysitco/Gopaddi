//
//  OnboardingViewController.swift
//  Gopaddi
//
//  Created by jizan k on 15/12/22.
//

//import UIKit
//
//class OnboardingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    let utilityF = UtilitiesFunctions()
//    @IBOutlet weak var pageControl: UIPageControl!
//    
//    @IBOutlet weak var collection: UICollectionView!
//    @IBOutlet weak var nextButton: UIButton!
//    var currentpage = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collection.delegate = self
//        collection.dataSource = self
//        collection.register(UINib.init(nibName: "OnboardingFirstCell", bundle: nil),forCellWithReuseIdentifier: "OnboardingFirstCell")
//        collection.register(UINib.init(nibName: "OnboardingSecondCell", bundle: nil),forCellWithReuseIdentifier: "OnboardingSecondCell")
//        collection.register(UINib.init(nibName: "OnboardingThirdCell", bundle: nil),forCellWithReuseIdentifier: "OnboardingThirdCell")
//
//    }
//    @IBAction func CreateButton(_ sender: UIButton) {
//    }
//
//    @IBAction func LoginButton(_ sender: UIButton) {
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let x = targetContentOffset.pointee.x
//        pageControl.currentPage = Int(x / view.frame.width)
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingFirstCell", for: indexPath)as! OnboardingFirstCell
//            return cell
//
//        }else if indexPath.section == 1 {
//            let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingSecondCell", for: indexPath)as! OnboardingSecondCell
//            return cell
//        }else{
//            let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingThirdCell", for: indexPath)as! OnboardingThirdCell
//            return cell
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let W = view.frame.width
//        let H = view.frame.height
//
//        return CGSize(width: W, height: H)
//    }
//
//
//}
