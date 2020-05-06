//
//  FetchableImageResponse.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 05.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import UIKit

protocol FetchableImageResponseable {
    var image: Data {get}
}

struct FetchableImageResponse: FetchableImageResponseable {
    var image: Data
}
