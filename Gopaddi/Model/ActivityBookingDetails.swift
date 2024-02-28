//
//  ActivityBookingDetails.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//


struct ActivityBookingDetails : Codable {
    let code: String
    let result: [ActivityBookingDetailsResult]?
}
struct ActivityBookingDetailsResult : Codable{
    let acbId: String
    let activityImage: String
    let activityTitle, bookingDate, currency, totalPrice: String
    let name, email, phone, hotel: String
    let checkIn, adultNo, childNo, bookingReference: String
    let cancellationPolicy: [CancelPolicy]
    let booking_status: String
}


struct CancelPolicy : Codable {
    let amount: Double
    let dateFrom: String
}
