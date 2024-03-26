//
//  ResentPasswordModel.swift
//  Gopaddi
//
//  Created by admin on 25/03/24.
//

import Foundation

struct ResentPasswordModel: Codable {
    let success: Bool
    let status: String
    let alerts: String?
    let data: [Datum]?
    let errors: [ErrorDetail]?
}
