//
//  Result.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 30.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
  case success(T)
  case failure(U)
}
