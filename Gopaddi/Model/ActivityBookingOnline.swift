//
//  ActivityBookingOnline.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import Foundation

struct ActivityBookingOnline : Codable {
    let code, message: String
    let redirect: String?
    let  key : String?
    let success_url: String?
}


struct ActivityBookingWeb : Codable {
    let code, message: String
    let redirect: String?
    let  key : String?
}

// Activity Input
struct ActivityBookingInput : Codable {
    let searchId : String?
    let title:[String?]
    let fName:[String?]
    let lName:[String?]
    let childtitle:[String?]
    let chfName:[String?]
    let childlast:[String?]
    let userId:String?
    let adultPrice:String?
    let adultNo : String?
    let childPrice:String?
    let childNo:String?
    let totalPrice:String?
    let email:String?
    let contactNumber:String?
    let address:String?
    let checkIn:String?
    let from : String?
    let to : String?
    let hotel:String?
    let ActivityName:String?
    let ActivityImage:String?
    let duration:String?
    let rateKey:String?
    let currency : String?
    init(searchId: String?, title: [String?], fName: [String?], lName: [String?], childtitle: [String?], chfName: [String?], childlast: [String?], userId: String?, adultPrice: String?, adultNo: String?, childPrice: String?, childNo: String?, totalPrice: String?, email: String?, contactNumber: String?, address: String?, checkIn: String?, from: String?, to: String?, hotel: String?, ActivityName: String?, ActivityImage: String?, duration: String?, rateKey: String?, currency: String?) {
        self.searchId = searchId
        self.title = title
        self.fName = fName
        self.lName = lName
        self.childtitle = childtitle
        self.chfName = chfName
        self.childlast = childlast
        self.userId = userId
        self.adultPrice = adultPrice
        self.adultNo = adultNo
        self.childPrice = childPrice
        self.childNo = childNo
        self.totalPrice = totalPrice
        self.email = email
        self.contactNumber = contactNumber
        self.address = address
        self.checkIn = checkIn
        self.from = from
        self.to = to
        self.hotel = hotel
        self.ActivityName = ActivityName
        self.ActivityImage = ActivityImage
        self.duration = duration
        self.rateKey = rateKey
        self.currency = currency
    }
}
