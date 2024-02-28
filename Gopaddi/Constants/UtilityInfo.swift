//
//  InterestData.swift
//  Gopaddi
//
//  Created by jizan k on 24/01/23.
//

import Foundation
import UIKit

struct InterestData {
    let image : UIImage
    let title : String
}

let interestData : [InterestData] = [
    InterestData(image: UIImage(named: "travel (1)")!, title: "Travel"),
    InterestData(image: UIImage(named: "vacation- (1)")!, title: "Vacation"),
    InterestData(image: UIImage(named: "study (1)")!, title: "Study"),
    InterestData(image: UIImage(named: "medical (1)")!, title: "Medical"),
    InterestData(image: UIImage(named: "burj- (1)")!, title: "Hotels"),
    InterestData(image: UIImage(named: "airplane (1)")!, title: "Flight"),
    InterestData(image: UIImage(named: "climbing- (1)")!, title: "Activites"),
    InterestData(image: UIImage(named: "immigration-g (1)")!, title: "Immigration"),
]


struct SettingsHead {
    var title : String
    var icon : UIImage
}
let settingsHead = [ SettingsHead(title: "Personal", icon: UIImage(named: "Vector (2)")!),
                      SettingsHead(title: "Terms & Conditions", icon: UIImage(named: "Vector (2)")!),
                      SettingsHead(title: "Security Settings", icon: UIImage(named: "Vector (2)")!),
                      SettingsHead(title: "Delete", icon: UIImage(named: "Vector (2)")!),
                      SettingsHead(title: "Sign Out", icon: UIImage(named: "Vector (2)")!),
                      ]


var profileTitle : [String] = ["Name :" , "UserId :" , "Occupation :", "Email :" ," Phone :" , "Gender :"]


struct MenuPage {
    var title : String
    var icon : UIImage
}
let menuPage = [ MenuPage(title: "My QR Code", icon: UIImage(named: "qrcode")!),
                 MenuPage(title: "Settings", icon: UIImage(named: "settings")!),
                 MenuPage(title: "My Bookings", icon: UIImage(systemName: "cube.box.fill")!),
                 MenuPage(title: "My cart", icon: UIImage(systemName: "cart.fill")!),
                 MenuPage(title: "Request for Blue Tick", icon: UIImage(named: "tick")!),
                 MenuPage(title: "help & Support", icon: UIImage(named: "help")!),
                 MenuPage(title: "Logout", icon: UIImage(named: "logout")!)]
