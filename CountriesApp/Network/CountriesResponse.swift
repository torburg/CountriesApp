//
//  CountriesResponse.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 30.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

protocol FetcheableResponse {
    var next: String { get set }
    var countries: [Country] { get set }
}

struct CountriesResponse: FetcheableResponse, Decodable {
    var next: String
    var countries: [Country]
}
