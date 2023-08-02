//
//  GlobalStore.swift
//  SMHS
//
//  Created by Jevon Mao on 9/6/21.
//

import Foundation
import SwiftUI

//MARK: This file contains global, pre-defined constants
struct Constants {
}

extension Constants {

    struct Color {
        //MARK: - App-wide Constant Values
        private static let primaryKey = "primary_color"
        static let primaryHex = "B30A0E"
        private static let secondaryKey = "secondary_color"
        static let secondaryHex = "595959"
    }

    struct MvhsApiPath {
        static let host = "https://maryvilleschoolsorg.finalsite.com"
        static let news = "/fs/mobile-manager/apps/1/nav_section/2.json"
        static let detailedNews = "/fs/mobile-manager/apps/1/nav_section/2/posts/720/mvhs.json"
        static let xAppKey = "ZmExZmQ3NjY0ZGU5MzZlNWMzNmNjMTEy"
        static let xAppVersion = "4.16.1"
    }

    struct AeriesApiPath {
        static let host = "aeries.smhs.org"
        static let main = "/parent/m/api/MobileWebAPI.asmx"
        static let login = "/parent/LoginParent.aspx"
        static let altGrades = "/Parent/Widgets/ClassSummary/GetClassSummary"
        static let summaryGrades = "/GetGradebookSummaryData"
        static let detailedGrades = "/GetGradebookDetailsData"
        static let detailedSummary = "/GetGradebookDetailedSummaryData"


        static let pageSize = "200"
        static let requestedPage = "1"
    }

    struct AppServApiPath {
        static let host = "appserv.u360mobile.com"
        static let schedule = "/354/calendarfeed.php"


        static var pageSize: String {
            "300"
        }
        static let pageNumber = "1"
        static let categoryId = "0"
        static let mid = "1422"
        static let smid = "46492"
    }

    static let gradesEmailErrorMsg = "Invalid email address, please use your SMHS email."

    static let gradesPasswordErrorMsg = "Password must not be empty."
}

extension Constants {
    struct Labels {

    }

    struct Errors {
        /* Error code conventions:
         Code should span from 1001 to 9001, changing the right most digit
         only until more codes are needed, in which case the second digit
         from left is used. There should always be a zero seperating code
         numbers, for easier recognition, if possible. The higher the code number,
         the more severe the error. Eg. harmless warnings should be 1001, while
         severe errors should be 9001.
        */
        static let scheduleUserFeedbackCode = 5001
        static let scheduleUserFeedbackDescription = "User submitted a feedback. Possible schedule error."
    }
}
