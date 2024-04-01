//
//  PostResponseModel.swift
//  Gopaddi
//
//  Created by admin on 29/03/24.
//

import Foundation
struct PostResponseModel: Codable {
    let success: Bool?
    let message: String?
    let data: [PostData]?
}

struct PostData: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let id: String
    let userinfo: [UserInfo]
    let caption: String
    let files: [PostFile]
    let likesCount: String
    let likedStatus: Bool
    let savesCount: String
    let savedStatus: Bool
    let sharesCount: String
    let commentsCount: String
    let viewsCount: String
    let createdAt: String
    let promotion: Bool
    let diary: Bool
}

struct UserInfo: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let username: String
    let picture: String
}

struct PostFile: Codable {
    let id: String
    let url: String
}

//
//struct FeedResult : Codable {
//    let fe_id: String
//    let fe_creator: [FeCreator]
//    let fe_caption: String
//    let fe_file: String
//    let fe_likes, fe_liked, fe_saves, fe_saved: String
//    let fe_shares, fe_comments, fe_views, fe_created: String
//    let fe_created_at, fe_promotion: String
//}
//struct FeCreator : Codable{
//    let us_id, us_name: String
//    let us_picture: String
//}
