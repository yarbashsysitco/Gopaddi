//
//  webviewResponseModel.swift
//  Gopaddi
//
//  Created by jizan k on 27/01/23.
//

import Foundation
class WebviewResponseModel : Codable {
    let code : String
    let message : String
    let key : String?
    let redirect : String?
}
