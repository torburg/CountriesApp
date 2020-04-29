//
//  FetchingResult.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 25.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

struct FetchResult: Codable {
    let next: String
    let countries: [Country]
}
