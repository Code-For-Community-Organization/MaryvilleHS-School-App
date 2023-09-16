//
//  Downloader.swift
//  MVHS
//
//  Created by Jevon Mao on 8/31/23.
//

import Foundation

struct Downloader {
    static func load(_ urlString: String, accept: String = "*/*", completion: @escaping (Data?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.allHTTPHeaderFields = ["User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36",
                                       "Accept": accept]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil, error!)
                return
            }
            completion(data, nil)
        }
        task.resume()
    }

    static func mockLoad(_ text: String, completion: @escaping (Data?, Error?) -> ()) {
        completion(text.data(using: .utf8), nil)
    }
}
