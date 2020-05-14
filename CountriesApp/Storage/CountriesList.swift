//
//  CountriesList.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 07.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

class CountriesList: Saveable, Codable {
    
    private(set) var items: [Country] = []
    
    static var shared = CountriesList()
    
    lazy var count: Int = {
        return items.count
    }()
    
    public func setNewItems(_ items: [Country]) {
        self.items = items
    }

    public func add(_ country: Country) {
        items.append(country)
    }
    
    public func contains(_ country: Country) -> Bool {
        return items.contains(where: { $0 == country } )
    }
    
    public func remove(_ country: Country) {
        items = items.filter { $0 != country }
    }
    
    public func update(_ country: Country) {
        remove(country)
        add(country)
    }
    
    public func sorted() {
        self.items = items.sorted{ $0.name < $1.name }
    }
}

