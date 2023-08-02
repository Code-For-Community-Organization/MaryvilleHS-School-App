//
//  SharedScheduleInformation.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import Combine
import Foundation


final class SharedScheduleInformation: ObservableObject {
    @Storage(key: "lastReloadTime", defaultValue: nil) private var lastReloadTime: Date?
    @Published var todaySchedule: ScheduleDay?
    @Published(key: "scheduleWeeks") var scheduleWeeks = [ScheduleWeek]()
    @Published var isLoading = false
    @Published(key: "scheduleLastUpdateTime") var scheduleLastUpdateTime: Date? = Date()

    private var currentWeekday: Int?

    private var urlString: String = "https://www.smhs.org/calendar/calendar_379.ics"
    var dateHelper: ScheduleDateHelper = ScheduleDateHelper()
    var currentDaySchedule: ScheduleDay? {
//        if let today = todaySchedule,
//           scheduleWeeks.isEmpty {
//            return today
//        }
//        let targetDay = scheduleWeeks.compactMap{$0.getDayByDate(Date())}
//        return targetDay.first
        var day = ScheduleDay(date: Date(), scheduleText: "")
        day.periods.append(.init("First Period",
                                 startTime: DateFormatter.hourTimeFormat("8:25AM")!,
                                 endTime: DateFormatter.hourTimeFormat("9:55AM")!))
        day.periods.append(.init("Second Period",
                                 startTime: DateFormatter.hourTimeFormat("10:10AM")!,
                                 endTime: DateFormatter.hourTimeFormat("11:40AM")!))
        day.periods.append(.init(category: .firstLunch,
                                 startTime: DateFormatter.hourTimeFormat("11:43AM")!,
                                 endTime: DateFormatter.hourTimeFormat("12:13PM")!))
        day.periods.append(.init(category: .firstLunchPeriod,
                                 periodNumber: 3, startTime: DateFormatter.hourTimeFormat("12:17PM")!,
                                 endTime: DateFormatter.hourTimeFormat("1:48PM")!))
        day.periods.append(.init(category: .secondLunch,
                                 startTime: DateFormatter.hourTimeFormat("11:43AM")!,
                                 endTime: DateFormatter.hourTimeFormat("12:13PM")!))
        day.periods.append(.init(category: .secondLunchPeriod,
                                 periodNumber: 3, startTime: DateFormatter.hourTimeFormat("12:17PM")!,
                                 endTime: DateFormatter.hourTimeFormat("1:48PM")!))

        return day
    }

    var scheduleLastUpdateDisplay: String {
        if let lastUpdateTime = scheduleLastUpdateTime {
            return lastUpdateTime.timeAgoDisplay()
        }
        else {
            return "unknown"
        }
    }
    // Fetched through API metadata
    // Represents the start and end of school year
    @Published(key: "minDate") private var minDate: Date? = nil
    @Published(key: "maxDate") private var maxDate: Date? = nil

    init(placeholderText: String? = nil,
         scheduleDateHelper: ScheduleDateHelper = ScheduleDateHelper(),
         purge: Bool = false,
         urlString: String = "https://www.smhs.org/calendar/calendar_379.ics",
         semaphore: DispatchSemaphore? = nil) {

        self.dateHelper = scheduleDateHelper
        self.urlString = urlString
    }

}
