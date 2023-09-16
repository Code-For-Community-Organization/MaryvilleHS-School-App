//
//  ContentView.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayView(scheduleViewViewModel: SharedScheduleInformation())
                .tabItem{
                    Label("Today", systemSymbol: .squareGrid2x2Fill)
                }
            MasterCalendarView(calendarViewModel: MasterCalendarViewModel())
                .tabItem{
                    Label("Calendar", systemSymbol: .calendar)
                }
            NewsView()
                .tabItem{
                    Label("News", systemSymbol: .newspaperFill)
                }
        }
        .tint(.appPrimary)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
