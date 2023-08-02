//
//  URL.swift
//  MVHS
//
//  Created by Jevon Mao on 8/2/23.
//

import Foundation

extension URLSession {
    static let defaultHost = Constants.MvhsApiPath.host

    func sendMvhsGetRequest(path: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlString = "\(URLSession.defaultHost)" + "\(path)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.addValue(Constants.MvhsApiPath.xAppKey, forHTTPHeaderField: "X-App-Key")
        request.addValue(Constants.MvhsApiPath.xAppVersion, forHTTPHeaderField: "X-App-Version")
        request.addValue(generateRandomUserAgent(), forHTTPHeaderField: "User-Agent")
        let task = self.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }

    func generateRandomUserAgent() -> String {
        let userAgents = [
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101 Firefox/90.0",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7; rv:90.0) Gecko/20100101 Firefox/90.0",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0) Gecko/20100101 Firefox/92.0",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7; rv:92.0) Gecko/20100101 Firefox/92.0",
        ]

        let randomIndex = Int.random(in: 0..<userAgents.count)
        return userAgents[randomIndex]
    }
}
