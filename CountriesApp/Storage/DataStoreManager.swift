//
//  DataStoreManager.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 12.05.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

protocol Saveable: Codable {
    associatedtype T
    var items: [T] { get }
}

class DataStoreManager {
    
    var path: String?
    let filename: String = "CountryList"
    
    init(path: String) {
        self.path = path
    }
    
    public func save<collection: Saveable>(data: collection) throws {
        if let fileUrlValue = getURL(of: path!) {
            let encoder = JSONEncoder()
            let jsData = try encoder.encode(data)
            try jsData.write(to: fileUrlValue)
        }
    }
    
    public func load() throws {
        if let fileUrlValue = getURL(of: path!) {
            guard let data = FileManager.default.contents(atPath: fileUrlValue.path) else { return }
            print("Recieve JSON String: \(data)")
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(CountriesList.self, from: data) else {
                CountriesList.shared.setNewItems([])
                return
            }
            CountriesList.shared.setNewItems(result.items)
        }
    }
    
    private func getURL(of storeName: String) -> URL? {

        guard let path = FileManager.default.urls(for: .userDirectory, in: .userDomainMask).first else {
            return nil
        }
        var isDir: ObjCBool = false

        let dirUrl = path.appendingPathComponent(storeName)
        if !FileManager.default.fileExists(atPath: dirUrl.path, isDirectory: &isDir), !isDir.boolValue {
            do {
                try FileManager.default.createDirectory(at: dirUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Unable to create directory named \(storeName), with \(error)")
                return nil
            }
        }
        let fileUrl = dirUrl.appendingPathComponent(filename)
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            if !FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil) {
                return nil
            }
        }
        return fileUrl
    }
}
