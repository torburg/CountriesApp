//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 30.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

protocol CountriesViewModelDelegate: class {
    func fetchCompleted()
    func fetchFailed()
}

class CountriesViewModel {
    private weak var delegate: CountriesViewModelDelegate?
    let fetcher = Fetcher()
    private(set) var countries: [Country] = [] //CountriesFetcher().items
    
    private let endPoint = "https://rawgit.com/NikitaAsabin/"
    private var currentPage: String = "799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    
    init(with delegate: CountriesViewModelDelegate) {
        self.delegate = delegate
    }

    func fetchCountries() {
        let url = endPoint + currentPage
        fetcher.getResults(from: url, for: currentPage) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    // TODO: - get data from local url
                    print(error)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    //FIXME: - Fix results processing
                    self.currentPage = response.next
                    self.countries.append(contentsOf: response.countries)
                    self.delegate?.fetchCompleted()
                }
            }
        }
    }
}
