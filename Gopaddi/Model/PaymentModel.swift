//
//  PaymentModel.swift
//  Gopaddi
//
//  Created by jizan k on 24/01/23.
//

import Foundation
struct PaymentModel : Codable{
    let code : String
    let redirect : String
    let callback : String
}
