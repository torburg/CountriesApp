//
//  CountriesFetcher.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 25.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

class CountriesFetcher {
    var items = [Country]()
    var nextPage = ""
    let transferProtocol = "https://"
    let domain = "rawgit.com/NikitaAsabin/"
    
    var pathString = "799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    init() {
        load()
    }
    
    private func load() {
        guard let url = getURL() else {
            print("Cannot get URL")
            return
        }
        if let data = performStoreRequest(with: url) {
            print("Recieve JSON String: \(data)")
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(FetchResult.self, from: data)
                items = result.countries
                if !result.next.isEmpty {
                    nextPage = result.next
                }
              } catch {
                  print("JSON Error: \(error)")
                  items = []
            }
        }
    }
    
    private func getURL() -> URL? {
        let urlString = transferProtocol + domain + pathString
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    private func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }
    
}


extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
