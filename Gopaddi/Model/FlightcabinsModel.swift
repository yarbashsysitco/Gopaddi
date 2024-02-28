//
//  FlightcabinsModel.swift
//  Gopaddi
//
//  Created by admin on 25/10/23.
//

import Foundation


struct FlightcabinsModel: Codable  {
    let code: String
    let result: [Cabin]?
}

struct Cabin: Codable  {
    let code: String
    let title: String
}

