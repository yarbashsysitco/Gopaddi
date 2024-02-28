//
//  CountryModel.swift
//  Gopaddi
//
//  Created by jizan k on 06/02/23.
//

import Foundation

struct Countries: Codable {
    let code: String
    let result: [CountryResult]
}

struct CountryResult: Codable {
    let key, title, phonecode: String
    let flag: String
}

struct CountryData: Codable {
    var key  : String = "15"
    var title  : String = "Azarbaijan"
    var phonecode : String = "+994"
    init(key: String, title: String, phonecode: String) {
        self.key = key
        self.title = title
        self.phonecode = phonecode
    }
}
