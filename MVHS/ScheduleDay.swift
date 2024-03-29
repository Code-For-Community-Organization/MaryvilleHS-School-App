//
//  ClassPeriod.swift
//  SMHS Schedule
//
//  Created by Jevon Mao on 3/15/21.
//

import Foundation

struct ScheduleDay: Hashable, Identifiable, Codable {
    internal init(date: Date, scheduleText: String, mockDate: Date? = nil) {
        self.date = date
        self.scheduleText = scheduleText
        self.mockDate = mockDate
    }

    internal init(date: Date, scheduleText: String, dayTitle: String) {
        self.init(date: date, scheduleText: scheduleText)
        self.dayTitle = dayTitle
    }

    internal init(date: Date, scheduleText: String) {
        self.init(date: date, scheduleText: scheduleText, mockDate: nil)
    }

    var mockDate: Date?  //Mock representation of current date, for testing
    var id: Int {
        return date.hashValue
    }
    var dayOfTheWeek: Int {
        Date.getDayOfTheWeek(for: mockDate ?? date)
    }
    var date: Date  //Date of the schedule
    var scheduleText: String
    var dayTitle: String?

    var customPeriods = [ClassPeriod]()  //Future feature, no use for now
    var periods = [ClassPeriod]()

    var atheleticsInfo: String {
        return ""
    }
    
    var currentDate: Date {
        return mockDate ?? Date()
    }
    // Local time kept, but date information erased
    private var currentDateReferenceTime: Date {
        currentDate.convertToReferenceDateLocalTime()
    }

    var title: String {

        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
    }


    func getCurrentPeriodRemainingTime(selectionMode: PeriodCategory) -> TimeInterval? {
        if let endTime = getCurrentPeriod(selectionMode: selectionMode)?.endTime {
            return endTime - currentDateReferenceTime
        }

        //Handle passing periods
        else if isWithinSchoolHours() {
            guard let nextPeriod = getNextPeriod(selectionMode: selectionMode)
            else {
                return nil
            }
            return nextPeriod.startTime - currentDateReferenceTime
        }
        else {
            return nil
        }
    }
    
    func getCurrentPeriodRemainingPercent(selectionMode: PeriodCategory) -> Double? {
        if let endTime = getCurrentPeriod(selectionMode: selectionMode)?.endTime,
           let startTime = getCurrentPeriod(selectionMode: selectionMode)?.startTime,
           let timeRemaining = getCurrentPeriodRemainingTime(selectionMode: selectionMode) {
            let totalTime = endTime - startTime
            return timeRemaining / totalTime
        }

        //Handle passing periods
        else if isWithinSchoolHours() {
            guard let nextPeriod = getNextPeriod(selectionMode: selectionMode),
                  let previousPeriod = getPreviousPeriod(selectionMode: selectionMode)
            else {
                return nil
            }

            let timeLeft = nextPeriod.startTime - currentDateReferenceTime
            let totalTime = nextPeriod.startTime - previousPeriod.endTime
            return timeLeft / totalTime
        }
        return nil
    }
    
    func getCurrentPeriod(selectionMode: PeriodCategory) -> ClassPeriod? {
        //Filter for periods that are possible as current period
        //Current time within period start/end time
        periods.filter {
            //All all periods that contains current time in between its start/end time
            guard currentDateReferenceTime.isBetween($0.startTime, and: $0.endTime) else {
                return false
            }
            //Compare against selectionMode only if current period is lunch revolving
            //Otherwise 1st 2nd lunch don't matter
            return $0.periodCategory ~=~ selectionMode
        }.first
    }

    private func getNextPeriod(selectionMode: PeriodCategory) -> ClassPeriod? {
        periods.filter {
            let isBeforeStartTime = currentDateReferenceTime < $0.startTime

            //Ensure lunch revolving periods correctly compared
            let isInSameLunchSchedule = $0.periodCategory ~=~ selectionMode
            return isBeforeStartTime && isInSameLunchSchedule
        }
        .first
    }

    private func getPreviousPeriod(selectionMode: PeriodCategory) -> ClassPeriod? {
        periods.filter {
            let isBeforeStartTime = currentDateReferenceTime > $0.endTime
            let isInSameLunchSchedule = $0.periodCategory ~=~ selectionMode
            return isBeforeStartTime && isInSameLunchSchedule
        }.last
    }

    func isWithinSchoolHours() -> Bool {
        guard let first = periods.first,
              let last = periods.last
        else {
            return false
        }
        // Check if current time is anywhere
        // between start of 1st period, and
        // end of last period
        return currentDateReferenceTime > first.startTime
        && currentDateReferenceTime < last.endTime
    }

}

extension ScheduleDay {
    static let schoolDay = DateFormatter().serverTimeFormat("2022-07-22T04:24:14+0000")!
    static let sampleScheduleDay = ScheduleDay(date: schoolDay, scheduleText: "Period 6 8:00-9:05\nPeriod 7 9:12-10:22\n(5 minutes for announcements)\nNutrition                      Period 1\n10:22-11:02                10:29-11:34\nPeriod 1                        Nutrition\n11:09-12:14                 11:34-12:14\nPeriod 2 12:21-1:26\nOffice Hours 1:33-2:30\n-------------------------------\nAP French Lang/Culture & Modern World Hist 8:00\nAP Macroeconomics 12:00\nB FS Golf vs MD 3:30\nB JV Golf @ JSerra 3:00\nB JV Tennis vs Servite 3:15\nB JV/V LAX @ JSerra 7:00/5:30\nB V Tennis @ Servite 2:30\nB V Vball @ JSerra 3:00\nG JV/V LAX @ Orange Luth 7:00/5:30\nG V Golf vs Rosary 4:30\nPossible G Soccer CIF\nSenior Graduation Ticket Distribution\n\nV Wrestling vs Aliso Niguel 1:30\n")
}

