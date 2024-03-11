//
//  OnboardingViewController.swift
//  Gopaddi
//
//  Created by jizan k on 15/12/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    let utilityF = UtilitiesFunctions()
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    var slideData : [OnboardingData] = []
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slideData.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            }else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
   
    }
    
}
extension OnboardingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.infoSetup(slideData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideData.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
}
