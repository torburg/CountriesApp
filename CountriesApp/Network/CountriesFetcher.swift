//
//  CountriesFetcher.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 25.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

class Fetcher {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
      self.session = session
    }

    func getResults(from urlString: String, for page: String, completion: @escaping (Result<FetcheableResponse, DataResponseError>)->Void) {

        let fullURL = urlString + page
        guard let url = URL(string: fullURL) else {
            print("Fail to create URL from url: \(urlString) and page: \(page)")
            return
        }
        session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                completion(Result.failure(DataResponseError.network))
                return
            }
            guard let data = data else {
                completion(Result.failure(DataResponseError.unknown))
                return
            }
            guard let decodedResponse = try? JSONDecoder().decode(CountriesResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
    func getImage(from urlString: String, completion: @escaping (Result<FetchableImageResponseable, DataResponseError>)->Void) {

        guard let url = URL(string: urlString) else {
            print("Fail to create URL from url: \(urlString)")
            return
        }
        session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                completion(Result.failure(DataResponseError.network))
                return
            }
            guard let data = data else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            let image = FetchableImageResponse(image: data)
            completion(Result.success(image))
        }).resume()
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
