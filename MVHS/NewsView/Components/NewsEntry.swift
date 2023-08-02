//
//  NewsEntry.swift
//  SMHSSchedule
//
//  Created by Jevon Mao on 5/10/21.
//

import Foundation
import Combine

struct NewsEntry: Hashable, Codable {
    var id: Int
    var title: String
    var imageURL: URL?
    var bodyText: String? = ""
}

extension NewsEntry {
    static let sampleEntries: [NewsEntry] = [.init(id: 721,
                                            title: "The Principal’s Office: Maryville Junior High School’s David Combs believes in having fun while getting the job done",
                                            imageURL: URL(string: "https://resources.finalsite.net/images/f_auto,q_auto,t_image_size_1/v1690831082/maryvilleschoolsorg/dek62uj7yrw3aez3ako7/DavidCombsDT.jpg")!)]
}
