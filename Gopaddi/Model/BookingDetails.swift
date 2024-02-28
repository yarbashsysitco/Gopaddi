//
//  BookingDetails.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//
import Foundation
struct BookingDetails : Codable {
    let code: String
    let result: [BookingDetailsResult]
}
struct BookingDetailsResult : Codable {
    let featureImage: String
    let totalPrice: String
}
