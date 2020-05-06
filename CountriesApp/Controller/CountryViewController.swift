//
//  CountryViewController.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 04.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var gallery: UICollectionView!
    @IBOutlet weak var countryDescription: UITextView!
    @IBOutlet weak var continent: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var countryName: UILabel!
    private let imagesCollection = GalleryCollectionView()
    @IBOutlet weak var imageControl: UIPageControl!
    @IBOutlet weak var countryInfoStack: UIStackView!
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gallery.dataSource = imagesCollection
        gallery.delegate = imagesCollection
        configure()
    }
    @IBAction func changeImage(_ sender: Any) {
    }

    func configure() {
        guard let country = country else {
            print("Empty country")
            return
        }
        countryName.text = country.name
        capital.text = country.capital
        population.text = country.population.formattedWithSeparator
        continent.text = country.continent.rawValue
        countryDescription.text = country.description
        let images = country.country_info.images
        if !images.isEmpty {
            imagesCollection.images = images
        } else if let flag = country.country_info.flag {
            imagesCollection.images.append(flag)
        }
        imagesCollection.imageControl = imageControl
        imageControl.numberOfPages = imagesCollection.images.count
        imageControl.currentPage = 0

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
}

extension Formatter {
    static let withseparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String {
        return Formatter.withseparator.string(for: self) ?? ""
    }
}
