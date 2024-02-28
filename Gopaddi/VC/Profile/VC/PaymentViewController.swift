//
//  PaymentViewController.swift
//  Gopaddi
//
//  Created by jizan k on 20/01/23.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    var userKey = String()
    let apiManager = ApiManager()
    var membershipData : [ResultData]?
    var paymentModel : PaymentModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        callMembership()
        
    }
    
    func setUp(){
        let period = " / " + (membershipData?[1].plans[0].period)!
        priceLbl.text = "N" + (membershipData?[1].plans[0].price)! + period
        descriptionLbl.text =  membershipData?[1].plans[0].description
    }
    func callMembership(){
        apiManager.memebership { result in
            switch result  {
            case.success(let model):
                DispatchQueue.main.async {
                    self.membershipData = model
                    self.setUp()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func callPayment(){
        let plan = "gold"
        let userKey = UserDefaults.standard.string(forKey: "logkey")
        apiManager.paymentDetails(userKey: userKey!, plan: plan) { result in
            switch result {
            case .success(let model) :
                self.paymentModel = model
                DispatchQueue.main.async {
                    if model.code == "200" {
                        let alert = UIAlertController(title: model.code, message: "Payment Response ", preferredStyle: .alert)
                        let alertButton = UIAlertAction(title: "OK", style: .default) { _ in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "webViewC") as? WebViewController
                            vc?.redirect = model.redirect
//                            vc?.modalPresentationStyle = .fullScreen
                            self.present(vc!, animated: true)
                        }
                        
                        alert.addAction(alertButton)
                        self.present(alert, animated: true)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
  
    @IBAction func skipButtonClicked(_ sender: Any) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func choosePlanClicked(_ sender: Any) {
        callPayment()
    }
    
    
}
