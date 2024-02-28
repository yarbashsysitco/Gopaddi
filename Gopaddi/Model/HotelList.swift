//
//  HotelList.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import Foundation

struct HotelListDetails : Codable {
    let code: String?
    let message : String?
    let result: [HotelListResult]?
}

struct HotelListResult : Codable{
    let hotelList: [HotelList]
    let searchId : Int
    let totalResults: Int
    let date: String
}
 
struct HotelList : Codable{
    let sessionId: String
    let token: String
    let productId: String
    let hotelId, hotelName: String
    let hotelRating: String
    let locality: String
    let totalPrice: Double
    let currency: String
    let image: String
    let nights : String
    let rooms: Int
}

//Input
struct Occupancy : Codable{
    var room_no : Int
    var adult : Int
    var child : Int
    var child_age : [Int]
    init(room_no: Int, adult: Int, child: Int, child_age: [Int]) {
        self.room_no = room_no
        self.adult = adult
        self.child = child
        self.child_age = child_age
    }
    }

