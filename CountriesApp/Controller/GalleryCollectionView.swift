//
//  GalleryCollectionView.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 05.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

protocol ImageSliderControlDelagate: class {
    func changeImage(_ sender: Any)
}

class GalleryCollectionView: UICollectionView {
    
    var images = [String]()
    var imageControl = UIPageControl()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)

        delegate = self
        dataSource = self
        automaticallyAdjustsScrollIndicatorInsets = false
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        let imageUrl = images[indexPath.row]
        cell.image.setImage(from: imageUrl)
        return cell
    }
}

extension GalleryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / scrollView.frame.width
        imageControl.currentPage = Int(scrollPos)
    }
}

