//
//  ActivityDetails.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//
//

struct ActivityDetails : Codable {
    let code: String
    let result: [ActivityDetailsResult]
}

 struct ActivityDetailsResult : Codable {
    let multiImage: [MultiImage]
    let featuredImage: String
    let ActivityName: String
    let cancellation: [Cancellation]
    let included: [Included]
    let DepartureAndReturn, discription, adultNo, childNo: String
    let activityPriceArray: [ActivityPriceArray]
}
struct ActivityPriceArray : Codable{
    let id: Int
    let priceTitle: String
    let adultPrice, childPrice: Double
    let rateKey: String
    let totalPrice: Double
    let duration: String
    let cancellationPolicy: [CancellationPolicy]
    let fromDate, toDate: String
}
struct Cancellation : Codable{
    let option, policy: String
}
struct Included : Codable{
    let description: String
}
struct CancellationPolicy : Codable{
    let amount: Double
    let dateFrom: String
}
struct MultiImage : Codable {
    let Image: String
}

//
//struct ActivityDetails : Codable {
//    let code: String
//    let result: [ActivityDetailsResult]
//}
//
// struct ActivityDetailsResult : Codable {
//    let multiImage: [MultiImage]
//    let featuredImage: String
//    let ActivityName: String
//    let cancellation: [Cancellation]
//    let included: [Included]
//    let DepartureAndReturn, discription, adultNo, childNo: String
//    let activityPriceArray: [ActivityPriceArray]
//}
//struct ActivityPriceArray : Codable{
//    let id: Int
//    let priceTitle: String
//    let adultPrice, childPrice: Double
//    let rateKey: String
//    let totalPrice: Double
//    let duration: String
//    let cancellationPolicy: [CancellationPolicy]
//}
//struct Cancellation : Codable{
//    let option, policy: String
//}
//struct Included : Codable{
//    let description: String
//}
//struct CancellationPolicy : Codable{
//    let amount: Double
//    let dateFrom: String
//}
//struct MultiImage : Codable {
//    let Image: String
//}
//
//
