//
//  ReactionMainViewController.swift
//  Gopaddi
//
//  Created by jizan k on 04/03/24.
//
 
import UIKit
 
class ReactionMainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
   
    var isselect = Int()
    var emojies = ["all","emosvg","Group2vg","Firesvg","Grhh","Thumbssvg","Airplansvg"]
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib.init(nibName: "ReactionCountCell", bundle: .main), forCellWithReuseIdentifier: "ReactionCountCell")
        
        tableview.delegate =  self
        tableview.dataSource = self
        tableview.register(UINib.init(nibName: "ViewReactionCell", bundle: .main), forCellReuseIdentifier: "ViewReactionCell")
    }
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ReactionCountCell", for: indexPath)as! ReactionCountCell
        cell.emojiImage.image = UIImage(named: emojies[indexPath.row])
        cell.emojiCountLabel.text = "35"
        
        if isselect == indexPath.row{
            cell.emojiview.layer.borderWidth = 1
            cell.emojiview.layer.borderColor = UIColor.systemBlue.cgColor
        }else{
            cell.emojiview.layer.borderColor = UIColor.lightGray.cgColor
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isselect = indexPath.row
        collectionView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ViewReactionCell", for: indexPath)as! ViewReactionCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
