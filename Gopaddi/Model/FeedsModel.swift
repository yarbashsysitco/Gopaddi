//
//  feedsModel.swift
//  Gopaddi
//
//  Created by jizan k on 31/01/23.
//

import Foundation
struct FeedsModel : Codable{
    let code: String
    let result: [FeedResult]
}
struct FeedResult : Codable {
    let fe_id: String
    let fe_creator: [FeCreator]
    let fe_caption: String
    let fe_file: String
    let fe_likes, fe_liked, fe_saves, fe_saved: String
    let fe_shares, fe_comments, fe_views, fe_created: String
    let fe_created_at, fe_promotion: String
}
struct FeCreator : Codable{
    let us_id, us_name: String
    let us_picture: String
}


//// Define the structure for the JSON response
//struct FeedResponse: Codable {
//    let code: String
//    let success: Bool
//    let message: String
//    let data: FeedData
//}
//
//struct FeedData: Codable {
//    let following: [Feed]?
//    let notfollowing: [Feed]?
//}
//
//struct Feed: Codable {
//    let feedId: String
//    let feedTitle: String
//    let feedCaption: String
//    let feedMessage: String
//    let feedFile: URL // Assuming the file is always a URL
//}
