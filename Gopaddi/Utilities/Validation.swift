//
//  Validation.swift
//  Gopaddi
//
//  Created by jizan k on 13/01/23.
//

import Foundation
import UIKit
class Validate {
    func isValid(name: String) -> Bool {
          let regex = "[A-Za-z]{2,}"
          let test = NSPredicate(format: "SELF MATCHES %@", regex)
          let result = test.evaluate(with: name)
          return result
      }
 
    func isValidEmail(email: String) -> Bool {
        let inputRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let inputPred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputPred.evaluate(with: email)
    }
   func isValidPhone(phone: String) -> Bool {
    let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
       let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
       return phoneTest.evaluate(with: phone)
   }
    func isValidPassword(password : String) -> Bool {
//        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx =  "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
}
extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@",
                  phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
                    return isValidPhone
    }
    var htmlToAttributedString: NSAttributedString? {
        return Data(utf8).htmlToAttributedString
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
extension Data {
    var htmlToAttributedString: NSAttributedString? {
        // Converts html to a formatted string.
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
