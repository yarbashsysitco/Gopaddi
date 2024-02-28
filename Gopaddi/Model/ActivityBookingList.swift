//
//  ActivityBookingList.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import Foundation
struct ActivityBookingList : Codable {
    let code: String
    let message : String?
    let result: [ActivityBookingListResult]?
}
struct ActivityBookingListResult : Codable{
    let acbId: String
    let activityImage: String?
    let activityTitle: String?
    let bookingDate: String
    let currency: String
    let totalPrice: String
}
