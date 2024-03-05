//
//  ReactionMainViewController.swift
//  Gopaddi
//
//  Created by jizan k on 04/03/24.
//
 
import UIKit
 
class ReactionMainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var isselect = Int()
    var emojies = ["all","emo1","emo2","emo3","emo4","emo5","emo6"]
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        collection.delegate = self
        collection.dataSource = self
//        self.collection.register(UINib.init(nibName: "ReactionCountCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ReactionCountCollectionViewCell")
        collection.register(UINib.init(nibName: "ReactionCountCell", bundle: .main), forCellWithReuseIdentifier: "ReactionCountCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ReactionCountCell", for: indexPath)as! ReactionCountCell
        cell.emojiImage.image = UIImage(named: emojies[indexPath.row])
//        if isselect == indexPath.row{
//            cell.emojiview.layer.borderWidth = 1
//            cell.emojiview.layer.borderColor = UIColor.systemBlue.cgColor
//        }else{
//            cell.emojiview.layer.borderColor = UIColor.lightGray.cgColor
//        }
//
        cell.emojiCountLabel.text = "35"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isselect = indexPath.row
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ReactionCountCell", for: indexPath)as! ReactionCountCell
        cell.emojiImage.image = UIImage(named: emojies[indexPath.row])
        if isselect == indexPath.row{
            cell.emojiview.layer.borderWidth = 1
            cell.emojiview.layer.borderColor = UIColor.systemBlue.cgColor
        }else{
            cell.emojiview.layer.borderColor = UIColor.lightGray.cgColor
        }
        collection.reloadData()
    }
}
