//
//  AppleSiningModel.swift
//  Gopaddi
//
//  Created by admin on 30/03/24.
//

import Foundation

import Foundation

// Define structs to model the JSON response
struct AppleSiningModel: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: [AppleData]
    let verify: Bool
}

struct AppleData: Codable {
    let user: [UserDetails]
}

struct UserDetails: Codable {
    let Userid: String?
    let email: String?
    let firstName: String?
    let lastName: String?
    let gender: String?
    let prefix: String?
    let phone: String?
    let category: String?
    let occupation: String?
    let parent: String?
    let picture: String?
    let plan: String?
    let role: String?
    let subscribed: String?
    let joined_at: String?
    let membership: String?
}
