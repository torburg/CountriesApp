//
//  Country.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 25.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let continent: Continent
    let capital: String
    let population: Int
    let descriptionSmall: String
    let description: String
    let image: String?
    let countryInfo: CountryInfo

    enum CodingKeys: String, CodingKey {
        case name, continent, capital, population, description, image
        case descriptionSmall = "description_small"
        case countryInfo      = "country_info"
    }
}

struct CountryInfo: Codable {
    let images: [String]
    let flag: String?
}

enum Continent: String, Codable {
    case Eurasia        = "Eurasia"
    case Australia      = "Australia"
    case SouthAmerica   = "South America"
    case Africa         = "Africa"
    case NorthAmerica   = "North America"
}

extension Country: Equatable {
    static func == (lhs: Country, rhs:Country) -> Bool {
        return lhs.name == rhs.name
    }

    static func != (lhs: Country, rhs:Country) -> Bool {
        return !(lhs == rhs)
    }
}
