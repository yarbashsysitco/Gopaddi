//
//  Registration.swift
//  Gopaddi
//
//  Created by jizan k on 04/01/23.
//
 
import Foundation
struct Register : Codable {
    let success : Bool?
    let code : String?
    let message : String?
    let userId: Int?
    let verify : Bool?
    let errors : [errorss]?
}
struct errorss : Codable {
    let email: String?
    let passconf: String?
    let password: String?
}
