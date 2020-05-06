//
//  GalleryCollectionViewCell.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 05.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "countryImageCollectionCell"
    
    var image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
