//
//  HotelDestiny.swift
//  Gopaddi
//
//  Created by jizan k on 12/05/23.
//

struct HotelDestiny : Codable {
    let code: String
    let result: [HDestinationData]
}
struct HDestinationData : Codable {
    let title, id, country: String
}
