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

            Text("A")
                .tabItem{
                    Label("Grades", systemSymbol: .graduationcapFill)

                }
            Text("A")
                .tabItem{
                    Label("Schedule", systemSymbol: .calendar)
                }
            NewsView()
                .tabItem{
                    Label("News", systemSymbol: .newspaperFill)
                }
            Text("A")
                .tabItem {
                    Label("Search", systemSymbol: .magnifyingglass)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
