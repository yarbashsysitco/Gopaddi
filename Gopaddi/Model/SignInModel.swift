//
//  SignInModel.swift
//  Gopaddi
//
//  Created by jizan k on 12/01/23.
//

import Foundation
//struct SignInModel : Codable {
//    let code : String
//    let message : String
//    let user : [user]?
//    let verify : Bool
//}
//struct user : Codable {
//    let key : String?
//    let name : String?
//    let username : String?
//    let email : String?
//    let phone : String?
//    let membership : String?
//    let category : String?
//    let plan : String?
//    let parent : Int?
//    let role : String?
//    let subscribed : String?
//    let verified : Int?
//    let picture : String?
//    let joined_at : String?
//}


struct SignInModel : Codable {
    let code, message: String
    let user: [User]?
    let verify: Bool?
}

// MARK: - User
struct User : Codable {
       let userID, firstName, lastName, email: String
       let phone, gender, occupation, membership: String
       let category, plan: String
       let parent: Int
       let role, subscribed: String
       let picture: String
       let joinedAt: String
}
