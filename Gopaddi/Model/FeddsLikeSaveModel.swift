//
//  feedSaveLikeModel.swift
//  Gopaddi
//
//  Created by jizan k on 08/02/23.
//


import Foundation

struct FeedLSModel : Codable {
    let code, message: String
    let result: [Response]?
}

struct Response : Codable {
    let fe_id: String?
    let likes, saves, shares, comments: Int?
    let views: String?
    let liked, saved: String?
}
