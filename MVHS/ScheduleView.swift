//
//  ScheduleView.swift
//  MVHS
//
//  Created by Jevon Mao on 8/31/23.
//

import SwiftUI

//struct ScheduleView: View {
//    @State private var presentCalendar = false
//    @StateObject private var masterCalendarViewModel = MasterCalendarViewModel()
//    var body: some View {
//        GeometryReader {geo in
//            ScrollView {
//                ScheduleListBanner(present: $presentCalendar, action: {
//                    masterCalendarViewModel.reloadData {
//                        presentCalendar = true
//                    }
//
//                }, geometryProxy: geo)
//            }
//        }
//        .fullScreenCover(isPresented: $presentCalendar, content: {
//            MasterCalendarView(calendarViewModel: masterCalendarViewModel)
//        })
//    }
//}
