//
//  BookMarkPopUp.swift
//  Gopaddi
//
//  Created by admin on 11/03/24.
//

import UIKit

class BookMarkPopUp: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SelectionButton(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateCategoryPopUp") as! CreateCategoryPopUp
        self.present(vc, animated: true)

    }

}
