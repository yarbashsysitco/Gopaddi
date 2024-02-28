//
//  HotelDetails.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import Foundation
struct HotelDetails : Codable {
    let code: String
    let message: String?
    let result: [HotelDetailsResult]?
}
struct  HotelDetailsResult : Codable {
    let hotelDetails: [HotelDetail]
}
struct HotelDetail : Codable {
    let nights, rooms, hotelName: String
      let images: [Image]
      let description, rating, location: String
      let roomrates: [Roomrate]
      let sessionId, productId, tokenId: String
      let occupancy: [HotelOccupancy]
}

struct Image : Codable{
    let caption: String
       let url: String
}
struct HotelOccupancy : Codable {
    let room_no, adult, child: Int
     let child_age: [Int]
}
struct Roomrate : Codable{
    let productId, roomType, description, roomCode: String
        let fareType, rateBasisId, currency: String
        let netPrice: Double
        let boardType: String
        let maxOccupancyPerRoom: Int
        let inventoryType, cancellationPolicy: String
        let roomImages, facilities: [String]
        let extrabeds: String
        let markup : Double
}

enum ChildAge : Codable{
    case integer(Int)
    case string(String)
}

struct DetailsHeadList{
    let name : String?
    let image : String?
}


