//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 30.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

protocol CountriesViewModelDelegate: class {
    func fetchCompleted(with newIndexPathsToReload: [IndexPath]?)
}

class CountriesViewModel {
    private weak var delegate: CountriesViewModelDelegate?
    private let fetcher = Fetcher()
    private var countries: [Country] = [] //CountriesFetcher().items
    
    private let endPoint = "https://rawgit.com/NikitaAsabin/"
    private let startPage: String = "799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    private lazy var currentPage = {
        return startPage
    }()
    private lazy var nextPage = {
        return startPage
    }()
    
    
    init(with delegate: CountriesViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getCountry(at index: Int) -> Country {
        return countries[index]
    }

    var itemsCount: Int {
        countries.count
    }
    
    func fetchCountries() {
        if nextPage.isEmpty {
            return
        }
        let url = endPoint + nextPage
        fetcher.getResults(from: url, for: currentPage) { result in
            switch result {
            case .failure(let fetchError):
                print(fetchError.reason)
                DispatchQueue.main.async {
                    do {
                        try CountriesList.shared.load(from: "Storage")
                    } catch {
                        print("Error to load \(error)")
                    }
                    self.countries = CountriesList.shared.countries
                    self.delegate?.fetchCompleted(with: .none)
                }
            case .success(let response):
                DispatchQueue.global().async {
                    for country in response.countries {
                        if CountriesList.shared.contains(country) {
                            CountriesList.shared.update(country)
                        } else {
                            CountriesList.shared.add(country)
                        }
                    }
                    do {
                        try CountriesList.shared.save(to: "Storage")
                    } catch {
                        print(error)
                    }
                }
                
                DispatchQueue.main.async {
                    if !self.nextPage.isEmpty {
                        self.currentPage = self.nextPage
                    }
                    let nextPage = response.next.deletingPrefix(self.endPoint)
                    self.nextPage = nextPage
                    self.countries.append(contentsOf: response.countries)

                    if self.nextPage != self.currentPage {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.countries)
                        self.delegate?.fetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.fetchCompleted(with: .none)
                    }
                }
            }
        }
    }

    private func calculateIndexPathsToReload(from newCountries: [Country]) -> [IndexPath] {
        let startIndex = countries.count - newCountries.count
        let endIndex = startIndex + newCountries.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
