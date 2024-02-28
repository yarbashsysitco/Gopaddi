//
//  AppDelegate.swift
//  Gopaddi 
//
//  Created by jizan k on 05/12/22.
//

import UIKit
import IQKeyboardManagerSwift
//import DropDown
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        DropDown.startListeningToKeyboard()
        Thread.sleep(forTimeInterval: 1.0)
        
        // Enable IQKeyboardManager
              IQKeyboardManager.shared.enable = true
              
//              // Customize IQKeyboardManager (Optional)
//              IQKeyboardManager.shared.enableAutoToolbar = true
//        IQKeyboardManager.shared.resignOnTouchOutside = true
        return true
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
  

}

