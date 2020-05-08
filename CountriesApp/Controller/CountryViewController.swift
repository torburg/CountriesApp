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
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoViewBottomConstraint: NSLayoutConstraint!
    
    var country: Country?
    var viewState: ViewState  = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gallery.dataSource = imagesCollection
        gallery.delegate = imagesCollection
        configure()
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
        let images = country.countryInfo.images
        if !images.isEmpty {
            imagesCollection.images = images
        } else if let flag = country.countryInfo.flag {
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
        
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 10
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveStackView(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveStackView(_:)))
        upSwipe.direction = .up
        downSwipe.direction = .down
        infoView.addGestureRecognizer(upSwipe)
        infoView.addGestureRecognizer(downSwipe)
    }
    
    @objc
    func moveStackView(_ gesture: UISwipeGestureRecognizer) {

        let galleryHeight = self.gallery.frame.height
        if (gesture.direction == .up && viewState == .normal) {
            let bottomOfNavigationBar = navigationController?.navigationBar.frame.maxY
            
            let frame = CGRect(x: infoView.frame.origin.x, y: bottomOfNavigationBar!, width: infoView.frame.size.width, height: infoView.frame.size.height)
            UIView.animate(withDuration: 0.3) {
                self.infoView.frame = frame
            }
            
            infoViewBottomConstraint.constant -= galleryHeight
            viewState = .extanded
            return
        }
        
        if (gesture.direction == .down && viewState == .extanded) {
            let bottomOfGallery = gallery.frame.maxY
            let frame = CGRect(x: infoView.frame.origin.x, y: bottomOfGallery, width: infoView.frame.size.width, height: infoView.frame.size.height)
            UIView.animate(withDuration: 0.3) {
                self.infoView.frame = frame
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.infoViewBottomConstraint.constant += galleryHeight
            }
            viewState = .normal
            return
        }
    }
    
    enum ViewState {
        case extanded
        case normal
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
