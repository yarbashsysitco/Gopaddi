//
//  LaunshViewController.swift
//  Gopaddi
//
//  Created by jizan k on 20/12/22.
//

import UIKit
class LaunshViewController: UIViewController {
    
    let utilFunc = UtilitiesFunctions()
    var signedIn = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a gradient layer
             let gradientLayer = CAGradientLayer()
             gradientLayer.frame = view.bounds
             
             // Define the colors of the gradient (white to clear)
             gradientLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
             
             // Define the direction of the gradient (from left to right)
             gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
             gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
             
             // Add the gradient layer to your view's layer
             view.layer.addSublayer(gradientLayer)
             
             // Create an animation for the gradient layer
             let animation = CABasicAnimation(keyPath: "locations")
             animation.fromValue = [-1.0, -0.5]
             animation.toValue = [1.5, 2.0]
             animation.duration = 2.0 // Adjust the duration as needed
             
             // Add the animation to the gradient layer
             gradientLayer.add(animation, forKey: "shineAnimation")
             
             // Delay for a few seconds to display the effect
             DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                 self.performSegue(withIdentifier: "MainSegue", sender: self)
             }

    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }

  
}
