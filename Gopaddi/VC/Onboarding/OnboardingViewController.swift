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
    @IBOutlet weak var collectionView: UICollectionView!
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
        
        slideData = [ OnboardingData(title : " Connect to a happy world around you" , description : "It's a big, happy world out there. Discover all you need to satisfy your travel needs seamlessly with us.", image: UIImage(imageLiteralResourceName: "SlideImg1")),
                      OnboardingData(title : "Find amazing things to do. Anytime, Anywhere" , description : "Search, book and explore the best travel deals we have planned towards ensuring a happy experience for you.", image: UIImage(imageLiteralResourceName: "SlideImg2")),
                      OnboardingData(title : "Save on the go" , description : "Enjoy our amazing member-only discount offers on all products, across all platforms.", image: UIImage(imageLiteralResourceName: "SlideImg3"))]
        collectionView.delegate = self
        collectionView.dataSource = self
   
    }
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slideData.count-1 {
            let controller = storyboard?.instantiateViewController(identifier: "SignInVC") as! SignInVC
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
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
