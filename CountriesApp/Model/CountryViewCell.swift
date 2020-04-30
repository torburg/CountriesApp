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
        
        // FIXME: - FIX bottom space in cell when description is empty
        detailDescription.text = country.description_small
        
        if let countryImageURL = country.image, !countryImageURL.isEmpty {
            loadImage(url: countryImageURL)
        } else if let countryFlagURL = country.country_info.flag, !countryFlagURL.isEmpty {
            loadImage(url: countryFlagURL)
        }
    }

    func loadImage(url: String) {
        guard let url = URL(string: url) else {print("Empty url"); return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { print("Empty data"); return }
            let image = UIImage(data: data) != nil ?  UIImage(data: data) : UIImage(named: "flag")
            DispatchQueue.main.async {
                self.avatar.image = image
            }
        }.resume()
    }
}
