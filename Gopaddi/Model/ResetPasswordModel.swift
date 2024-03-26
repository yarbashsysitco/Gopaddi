//
//  ResentPasswordModel.swift
//  Gopaddi
//
//  Created by admin on 25/03/24.
//

import Foundation

struct ResetPasswordModel: Codable {
    let success: Bool
    let status: String
    let alerts : String?
    let code: String?
    let errors: [passconfr]?
}
struct passconfr: Codable {
    let passconf: String?
}
