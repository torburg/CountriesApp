//
//  CountryViewCell.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 25.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import UIKit

class CountryViewCell: UITableViewCell {
    static let reuseIdentifier = "CountryCell"

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    
    func fill(with country: Country) {

        countryName.text = country.name
        capitalName.text = country.capital
        
        detailDescription.text = country.descriptionSmall
        
        if let countryImageURL = country.image, !countryImageURL.isEmpty {
            self.avatar.setImage(from: countryImageURL)
        } else if let countryFlagURL = country.countryInfo.flag, !countryFlagURL.isEmpty {
            self.avatar.setImage(from: countryFlagURL)
        } else {
            self.avatar.setImage()
        }
    }
}
