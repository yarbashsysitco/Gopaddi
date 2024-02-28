//
//  ActivityList.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import Foundation

struct ActivityListResponse : Codable {
    let code: String
    let message: String?
    let result: [ActivityListResult]?
}
struct ActivityListResult : Codable{
    let totalResults, searchId: Int
    let activityList: [ActivityList]
    let categories: String
    let currency: String
    let minprice, maxprice: Int
    let searchDate, searchLocation, searchCountry, searchCity: String
}
struct ActivityList :Codable{
    let activityType, activityName, description, duration: String
        let durationSplit: String
        let adultPrice: Double
        let currency, activityCode: String
        let featureImage: String
}
