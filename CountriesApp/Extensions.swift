//
//  Extensions.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 05.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from url: String = "") {
        if url.isEmpty {
            self.image = UIImage(named: "flag")
            return
        }
        let fetcher = Fetcher()
        fetcher.getImage(from: url) { result in
            switch result {
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.image = UIImage(named: "flag")
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.image = UIImage(data: response.image) ?? UIImage(named: "flag")
                }
            }
        }
    }
}
