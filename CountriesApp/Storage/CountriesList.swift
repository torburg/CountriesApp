//
//  CountriesList.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 07.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

class CountriesList {
    private(set) var countries: [Country] = []
    
    static var shared = CountriesList()

    public func add(_ country: Country) {
        countries.append(country)
    }
    
    public func contains(_ country: Country) -> Bool {
        return countries.contains(where: { $0 == country } )
    }
    
    public func remove(_ country: Country) {
        countries = countries.filter { $0 != country }
    }
    
    public func update(_ country: Country) {
        remove(country)
        add(country)
    }
    
    public func save(to fileName: String) throws {
        if let fileUrlValue = getURL(of: fileName) {
            let encoder = JSONEncoder()
            let items = countries.sorted { $0.name < $1.name }
            let array = CountryArray(items: items)
            let jsData = try encoder.encode(array)
            try jsData.write(to: fileUrlValue)
        }
    }
    
    public func load(from fileName: String) throws {
        if let fileUrlValue = getURL(of: fileName) {
            guard let data = FileManager.default.contents(atPath: fileUrlValue.path) else { return }
            print("Recieve JSON String: \(data)")
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(CountryArray.self, from: data) else {
                countries = []
                return
            }
            countries = result.items
        }
    }
    
    private func getURL(of fileName: String) -> URL? {

        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        var isDir: ObjCBool = false

        let dirUrl = path.appendingPathComponent(fileName)
        if !FileManager.default.fileExists(atPath: dirUrl.path, isDirectory: &isDir), !isDir.boolValue {
            do {
                try FileManager.default.createDirectory(at: dirUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Unable to create directory named \(fileName), with \(error)")
                return nil
            }
        }
        let fileUrl = dirUrl.appendingPathComponent("CountryList")
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            if !FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil) {
                return nil
            }
        }
        return fileUrl
    }
}

