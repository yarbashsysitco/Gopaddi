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
