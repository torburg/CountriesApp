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
    
    
    var list: CountriesList!
    var firstCountry: Country!
    
    override func setUpWithError() throws {
        list = CountriesList()
        firstCountry = Country(name: "Russia",
                        continent: .Eurasia,
                        capital: "Moscow",
                        population: 100000000,
                        descriptionSmall: "Rus desc",
                        description: "Russia Description",
                        image: "rus.img",
                        countryInfo: .init(images: ["img1", "img2"], flag: "flag.png"))
        
    }

    override func tearDownWithError() throws {
        list = nil
        firstCountry = nil
    }
    
    func testAdd() {
        list.add(firstCountry)
        
        let addedCountry = list.items.first
        XCTAssertNotNil(addedCountry)
        XCTAssert(addedCountry! == firstCountry)
    }
    
    func testContains() {
        list.add(firstCountry)
        
        XCTAssertTrue(list.contains(firstCountry))
    }
    
    func testRemove() {
        list.add(firstCountry)
        list.remove(firstCountry)
        XCTAssertFalse(list.contains(firstCountry))
    }
    
    func testUpdate() {
        list.add(firstCountry)
        
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
        let updatedCountry = list.items.first

        XCTAssertEqual(updatedCountry!, firstCountry)
        XCTAssertEqual(updatedCountry!.capital, capital)
    }
    
    func testSorted() {
        // Given
        let secondCountry = Country(name: "Albania",
                            continent: .Eurasia,
                            capital: "Capital",
                            population: 1,
                            descriptionSmall: "Alb desc",
                            description: "Albania Description",
                            image: "alb.img",
                            countryInfo: .init(images: ["img1", "img2"], flag: "flag.png"))
        list.add(firstCountry)
        list.add(secondCountry)
        // When
        list.sorted()
        // Then
        let first = list.items.first!
        let last = list.items.last!
        XCTAssertLessThan(first.name, last.name)
    }
    
    func testSetNewItems() {
        XCTAssertTrue(list.items.count == 0)
        
        let secondCountry = Country(name: "Albania",
                            continent: .Eurasia,
                            capital: "Capital",
                            population: 1,
                            descriptionSmall: "Alb desc",
                            description: "Albania Description",
                            image: "alb.img",
                            countryInfo: .init(images: ["img1", "img2"], flag: "flag.png"))
        let countries = [firstCountry!, secondCountry]
        list.setNewItems(countries)
        XCTAssertTrue(list.items.count == 2)
    }
}
