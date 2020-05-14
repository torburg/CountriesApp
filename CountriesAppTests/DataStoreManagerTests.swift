//
//  DataStoreManagerTests.swift
//  CountriesAppTests
//
//  Created by Maksim Torburg on 12.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import XCTest
@testable import CountriesApp

class DataStoreManagerTests: XCTestCase {
    
    var manager: DataStoreManager!
    let testPath = "testPath"
    let storeName = "Testable Store"
    
    struct Model: Saveable {
        var items: [Int]
    }
    var model: Model!

    
    override func setUpWithError() throws {
        manager = DataStoreManager(path: testPath)
        model = Model(items: [0, 1, 2])
    }

    override func tearDownWithError() throws {
        manager = nil
        model = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInit() {
        let newPath = "newPath"
        manager = DataStoreManager(path: newPath)
        
        XCTAssertEqual(manager.path, newPath)
    }
    
    func testSave() {
    }

    func testLoad() {
    }
}
