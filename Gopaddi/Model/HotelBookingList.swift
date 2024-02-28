//
//  HotelBookingList.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import Foundation

struct HotelBookingList : Codable {
    let code: String
    let message: String?
    let result: [HotelBookListResult]?
}

struct HotelBookListResult : Codable{
    let hb_id, hb_ref, hotelName: String
    let hotelImage: String?
    let hb_check_in, hb_check_out, hb_rooms, hb_nights: String
    let hb_adults, hb_childs: String
    let hb_contact: [HbContact]
    let roomBookDetails: [RoomBookDetail]
    let hb_response: [HbResponse]
    let hb_amount, hb_markup, hb_total: String
    let hb_currency: String
    let hb_cancelled, hb_failed, hb_status, hb_created_at: String
}

struct HbContact : Codable{
    let fname, lname, phone: String
    let email: String
}

struct HbResponse : Codable {
    let status: String
    let supplierConfirmationNum: String
    let referenceNum: Int
    let clientRefNum: String
    let productId: String
    let roomBookDetails: RoomBookDetail
    let error: String
}

struct RoomBookDetail : Codable{
    let hotelId, checkIn, checkOut: String
    let days: Int
    let currency: String
    let NetPrice: Double
    let fareType: String
    let cancellationPolicy: String
    let customerEmail: String
    let customerPhone: String
    let rooms: [Room]
}

struct Room : Codable{
    let name, description: String
    let boardType: String
    let paxDetails: PaxDetails
}

struct PaxDetails : Codable{
    let name: [String]
}

