//
//  DataResponseError.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 30.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    case unknown

    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data on \(self.localizedDescription)"
        case .decoding:
            return "An error occurred while decoding data on \(self.localizedDescription)"
        case .unknown:
            return "An unknown error with \(self.localizedDescription)"
        }
    }
}
