//
//  NewsViewViewModel.swift
//  SMHSSchedule
//
//  Created by Jevon Mao on 5/10/21.
//

import Foundation
import Combine
import SwiftyJSON

final class NewsViewViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published(key: "bookmarkedEntries") var bookMarkedEntries = [NewsEntry]()
    @Published(key: "newsEntries") var newsEntries = [NewsEntry]()
    @Published var isLoading: Bool = true
    init(newsEntries: [NewsEntry]? = nil) {
        self.newsEntries = newsEntries ?? []
        self.fetchNewsEntries()
    }
    
    func toggleEntryBookmarked(_ entry: NewsEntry) {
        if bookMarkedEntries.contains(where: {$0.id == entry.id}) {
            bookMarkedEntries = bookMarkedEntries.filter{$0.id != entry.id}
        }
        else {
            bookMarkedEntries.append(entry)
        }
    }

    func fetchNewsEntries() {
        var newsEntries = [NewsEntry]()
        URLSession.shared.sendMvhsGetRequest(path: Constants.MvhsApiPath.news) {data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data,
                  let json = try? JSON(data: data) else {
                print(String(data: data!, encoding: .utf8))
                return
            }
            guard let entries = json["$jason"]["head"]["actions"]["$load"]["success"]["success"]["options"]["item_data"].array
            else {
                return
            }
            for data in entries {
                let entry = NewsEntry(id: data["id"].intValue,
                                      title: data["title"].stringValue,
                                      imageURL: data["thumbnail_image"].url)
                if entry.title != "test" && entry.imageURL != nil {
                    newsEntries.append(entry)
                }
            }
            DispatchQueue.main.async {
                self.newsEntries = newsEntries
            }
        }

    }

}
