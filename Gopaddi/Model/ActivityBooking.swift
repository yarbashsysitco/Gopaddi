//
//  ActivityBooking.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import Foundation
struct ActivityBooking : Codable {
    let code : String
    let result : [ActivityBookingResult]
}
struct ActivityBookingResult :Codable{
    let featureImage : String
    let totalPrice : String
}
