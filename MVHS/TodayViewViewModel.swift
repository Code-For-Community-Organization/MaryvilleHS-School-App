//
//  TodayViewViewModel.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import Combine
import Foundation

class TodayViewViewModel: ObservableObject {
    @Published var showAnnoucement = false
    @Published var loadingAnnoucements = false
    @Published var showEditModal = false
    @Published var showNetworkError = true
    @Published var showTeamsBanner = true
    @Published var selectionMode: PeriodCategory = .firstLunch
    @Published var lastUpdateTime: Date?

    @Published var showToolbar = true

    var mockDate: Date?

    var isAnnoucementAvailable: Bool {
        todayAnnoucement != nil
    }

    var todayAnnoucement: AnnoucementResponse? {
        .init(fullHtml: "test", date: "10/12/2022")
    }

    var todayAnnoucementHTML: String? {
        todayAnnoucement?.getIncreasedFontSizeHTML()
    }

    var lastUpdateDisplay: String {
        if let lastUpdateTime = lastUpdateTime {
            return lastUpdateTime.timeAgoDisplay()
        }
        else {
            return "unknown"
        }
    }

    var anyCancellable: Set<AnyCancellable> = []

    init (mockDate: Date? = nil) {
        self.mockDate = mockDate
        $selectionMode
            .sink {_ in
                var hapticsManager = HapticsManager(impactStyle: .soft)
                hapticsManager.UIFeedbackImpact()
            }
            .store(in: &anyCancellable)
    }
}

extension TodayViewViewModel {
    static let mockViewModel: TodayViewViewModel = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let sampleDate = formatter.date(from: "2021/9/3")!
        return TodayViewViewModel(mockDate: sampleDate)
    }()
}
