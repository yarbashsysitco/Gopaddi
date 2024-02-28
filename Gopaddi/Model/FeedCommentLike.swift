//
//  FeedCommentLike.swift
//  Gopaddi
//
//  Created by jizan k on 01/06/23.
//

import Foundation
struct FeedCommentLike : Codable {
    let code: String
    let message: String
    let likes : Int?
    let liked : Int?
    let reacts : Int?
}
