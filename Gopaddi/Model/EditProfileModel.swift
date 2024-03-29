//
//  EditProfileModel.swift
//  Gopaddi
//
//  Created by admin on 27/03/24.
//

import Foundation

struct EditProfileModel : Codable {
    let code: String
    let message: String
    let user: [users]?
}
struct users : Codable {
    let fName: String
    let lName: String
    let email: String
    let phone: String
}
