//
//  AnnouncementResponse.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import Foundation

struct AnnoucementResponse: Codable, Hashable {
    var fullHtml: String
    var date: String

    func getIncreasedFontSizeHTML() -> String {
        let tag = #"<font size="+5">"#
        return tag + fullHtml
    }
}
