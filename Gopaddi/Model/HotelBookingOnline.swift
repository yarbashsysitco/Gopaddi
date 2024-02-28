//
//  HotelBookingOnline.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//


import Foundation

struct HotelBookingOnline : Codable {
    let code: String?
    let redirect, successURL: String?
}

struct HotelBookingWeb : Codable {
    let code, message: String
    let redirect: String?
    let  key : Int?
}

//Booking Input

struct PaxDetail : Codable {
    let roomNo: Int?
    let adult: [Adult]?
    let child: [Adult]?
}
struct PaxDetailA : Codable {
    let roomNo: Int?
    let adult: [Adult]?
}

struct Adult : Codable{
    let title, firstName, lastName: [String?]
}


struct HotelBookingInput : Codable {
    let amount : Double?
    let searchId : String?
    let userId:String?
    let sessionId:String?
    let tokenId : String?
    let productId:String?
    let rateBasisId:String?
    let nights:String?
    let rooms:String?
    let adults:String?
    let child:String?
    let email:String?
    let phone:String?
   
    init(amount : Double?,searchId: String?, userId: String?, sessionId: String?, tokenId: String?, productId: String?, rateBasisId: String?, nights: String?, rooms: String?, adults: String?, child: String?, email: String?, phone: String?) {
        self.amount = amount
        self.searchId = searchId
        self.userId = userId
        self.sessionId = sessionId
        self.tokenId = tokenId
        self.productId = productId
        self.rateBasisId = rateBasisId
        self.nights = nights
        self.rooms = rooms
        self.adults = adults
        self.child = child
        self.email = email
        self.phone = phone
    }
}
