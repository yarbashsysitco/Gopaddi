//
//  UtilityFunction.swift
//  Gopaddi
//
//  Created by jizan k on 12/01/23.
//

import Foundation
import UIKit
class UtilitiesFunctions {
    let defaults = UserDefaults.standard
    func saveLogging (_ isLogin: Bool){
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.userLogin)
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.name)
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.email)
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.gender)
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.nationality)
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.gender)
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.dob)
        defaults.set(isLogin, forKey: GlobalConstants.userLoginKeys.key)
        defaults.synchronize()
    }
    func isLoggedIn() -> Bool  {
        return defaults.bool(forKey: GlobalConstants.userLoginKeys.userLogin)
    }
    func isLogOut() {
        return defaults.removeObject(forKey: GlobalConstants.userLoginKeys.loginKey)
    }
    func removeLogging() {
        defaults.removeObject(forKey: "logkey")
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.userLogin)
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.name)
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.email)
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.gender)
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.nationality)
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.dob)
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.key)
        defaults.removeObject(forKey: GlobalConstants.userLoginKeys.loginKey)
        defaults.removeObject(forKey: "logname")
        defaults.removeObject(forKey: "logemail")
        defaults.removeObject(forKey: "loggender")
        defaults.removeObject(forKey: "logcountry")
        defaults.removeObject(forKey: "logdate")
        defaults.removeObject(forKey: "logphone")
        defaults.removeObject(forKey: "userLoginKey")
        defaults.removeObject(forKey: "gkey")
        defaults.removeObject(forKey: "isInterest")
        defaults.removeObject(forKey: "isUserName")
        defaults.removeObject(forKey: "MainTabBarController")
        defaults.removeObject(forKey: "personal")
        defaults.removeObject(forKey: "LoginTrue")
        
    }
}

struct ImageCompressor {
    static func compress(image: UIImage, maxByte: Int,
                         completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let currentImageSize = image.jpegData(compressionQuality: 1.0)?.count else {
                return completion(nil)
            }
        
            var iterationImage: UIImage? = image
            var iterationImageSize = currentImageSize
            var iterationCompression: CGFloat = 1.0
        
            while iterationImageSize > maxByte && iterationCompression > 0.01 {
                let percentageDecrease = getPercentageToDecreaseTo(forDataCount: iterationImageSize)
            
                let canvasSize = CGSize(width: image.size.width * iterationCompression,
                                        height: image.size.height * iterationCompression)
                UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
                defer { UIGraphicsEndImageContext() }
                image.draw(in: CGRect(origin: .zero, size: canvasSize))
                iterationImage = UIGraphicsGetImageFromCurrentImageContext()
            
                guard let newImageSize = iterationImage?.jpegData(compressionQuality: 1.0)?.count else {
                    return completion(nil)
                }
                iterationImageSize = newImageSize
                iterationCompression -= percentageDecrease
            }
            completion(iterationImage)
        }
    }

    private static func getPercentageToDecreaseTo(forDataCount dataCount: Int) -> CGFloat {
        switch dataCount {
        case 0..<5000000: return 0.03
        case 5000000..<10000000: return 0.1
        default: return 0.2
        }
    }
}
