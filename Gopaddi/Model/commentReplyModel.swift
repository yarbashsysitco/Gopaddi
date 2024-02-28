//
//  commentReplyModel.swift
//  Gopaddi
//
//  Created by jizan k on 23/02/23.
//


import Foundation
struct CommentReplyModel : Codable {
    let code: String
    let result: [ResponseInfo]?
}

struct ResponseInfo : Codable{
    let fc_id: String?
    let fc_commentor: [FcCommentor]?
    let fc_comment, fc_promotion, fc_created_at: String?
    let fc_replies: Int
    let fc_replies_data: [FcRepliesDatum]?
    let fc_likes, fc_liked: Int?
}

struct FcCommentor : Codable {
    let us_id, us_name: String?
    let us_picture: String?
}

struct FcRepliesDatum : Codable{
    let fc_id: String?
    let fc_commentor: [FcCommentor]?
    let fc_comment: String?
    let fc_promotion: Int?
    let fc_created_at, fc_replies: String?
    let fc_likes, fc_liked: Int?
}


struct ResponseInfo2 : Codable{
    let fc_id: String?
    let fc_commentor: [FcCommentor]?
    let fc_comment, fc_promotion, fc_created_at: String?
    let fc_replies: Int
    let fc_replies_data: [FcRepliesDatum]?
    let fc_likes, fc_liked: Int?
    var isReplyClicked : Bool = false
}

struct FcCommentor2 : Codable {
    let us_id, us_name: String?
    let us_picture: String?
}

struct FcRepliesDatum2 : Codable{
    let fc_id: String?
    let fc_commentor: [FcCommentor]?
    let fc_comment: String?
    let fc_promotion: Int?
    let fc_created_at, fc_replies: String?
    let fc_likes, fc_liked: Int?
}
