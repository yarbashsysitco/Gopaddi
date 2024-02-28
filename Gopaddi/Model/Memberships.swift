//
//  Memberships.swift
//  Gopaddi
//
//  Created by jizan k on 17/01/23.
//

import Foundation
struct Membership : Codable {
    let code : String
    let result : [ResultData]
}
struct ResultData : Codable {
    let key : String
    let title : String
    let description : String
    let plans : [Plans]
}
struct Plans : Codable {
    let key : String
    let title : String
    let description : String
    let price : String
    let period : String
}
