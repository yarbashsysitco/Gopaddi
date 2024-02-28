//
//  ActivityRedirect.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import Foundation

struct ActivityRedirect : Codable {
    let code: String
    let result: [ActivityRedirectResult]
}
struct ActivityRedirectResult : Codable {
    let reference, title: String
    let featureImage: String
    let travellers: Int
    let adults, childs, totalPrice, currency: String
    let paymethod: String
}
