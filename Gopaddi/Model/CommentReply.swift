//
//  CommentReply.swift
//  Gopaddi
//
//  Created by jizan k on 24/02/23.
//

//import Foundation
//struct CommentReply : Codable{
//    let code: String
//    let result: [ResultedData]?
//}
//
//struct ResultedData : Codable {
//    let fc_id: String?
//    let fc_commentor: [FcComment]?
//    let fc_comment: String?
//    let fc_promotion: Int?
//    let fc_created_at, fc_replies: String?
//    let fc_likes, fc_liked: Int?
//}
//
//struct FcComment: Codable {
//    let us_id, us_name: String?
//    let us_picture: String?
//}


import Foundation

// MARK: - Welcome4
struct CommentReply : Codable {
    let code: String
    let result: [ResultedData]?
}

// MARK: - Result
struct ResultedData : Codable {
    let fc_id: String?
    let fc_commentor: [FcComment]?
    let fc_comment: String?
    let fc_promotion: Int?
    let fc_created_at, fc_replies: String?
    let fc_likes, fc_liked: Int?
}

// MARK: - FcCommentor
struct FcComment : Codable{
    let us_id, us_name: String?
    let us_picture: String?
}
