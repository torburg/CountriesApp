//
//  CountrieListTests.swift
//  CountriesAppTests
//
//  Created by Maksim Torburg on 10.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import XCTest
@testable import CountriesApp

class CountrieListTests: XCTestCase {

    let country = Country(name: "Russia",
                          continent: .Eurasia,
                          capital: "Moscow",
                          population: 100000000,
                          descriptionSmall: "Rus desc",
                          description: "Russia Description",
                          image: "rus.img",
                          countryInfo: .init(images: ["img1", "img2"], flag: "flag.png"))
    
    func testAdd() {
        let list = CountriesList()
        list.add(country)
        
        let addedCountry = list.countries.first
        XCTAssertNotNil(addedCountry)
        XCTAssert(addedCountry! == country)
    }
    
    func testContains() {
        let list = CountriesList()
        list.add(country)
        
        XCTAssertTrue(list.contains(country))
    }
    
    func testRemove() {
        let list = CountriesList()
        list.add(country)
        list.remove(country)
        XCTAssertFalse(list.contains(country))
    }
    
    func testUpdate() {
        let list = CountriesList()
        list.add(country)
        
        let capital = "Saint-Petersburg"
        let newcapitalRussia = Country(name: "Russia",
                                continent: .Eurasia,
                                capital: capital,
                                population: 100000000,
                                descriptionSmall: "Rus desc",
                                description: "Russia Description",
                                image: "rus.img",
                                countryInfo: .init(images: ["img1", "img2"], flag: "flag.png"))
        list.update(newcapitalRussia)
        let updatedCountry = list.countries.first

        XCTAssert(updatedCountry! == country)
        XCTAssert(updatedCountry!.capital == capital)
    }
    
    func testSave() {
        
    }
    
    func testLoad() {
        
    }
}
