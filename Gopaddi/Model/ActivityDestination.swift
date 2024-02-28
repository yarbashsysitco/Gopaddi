//
//  ActivityDestination.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import Foundation
struct ActivityDestiny : Codable {
let code: String
let result: [DestinationData]
}
struct DestinationData : Codable {
let destinationList, cityId, countryId: String
}


struct DestinationResult: Codable {
    let destinationList, countryID, cityID: String

    enum CodingKeys: String, CodingKey {
        case destinationList
        case countryID = "countryId"
        case cityID = "cityId"
    }
}
