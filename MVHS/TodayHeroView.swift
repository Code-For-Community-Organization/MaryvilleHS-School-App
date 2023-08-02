//
//  TodayHeroView.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import SwiftUI
import SFSafeSymbols

struct TodayHeroView: View {
    @StateObject var scheduleViewViewModel: SharedScheduleInformation
    @StateObject var todayViewViewModel: TodayViewViewModel
    @Environment(\.openURL) var openURL
    @Namespace var animate
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    VStack {
                        Picker("", selection: $todayViewViewModel.selectionMode){
                            Text("1st Lunch")
                                .tag(PeriodCategory.firstLunch)
                            Text("2nd Lunch")
                                .tag(PeriodCategory.secondLunch)
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.top, -10)
                        
                        ProgressRingView(scheduleDay: scheduleViewViewModel.currentDaySchedule,
                                         selectionMode: $todayViewViewModel.selectionMode)
                        
                        if scheduleViewViewModel.currentDaySchedule != nil {
                            Text("Detailed Schedule")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .textAlign(.leading)
                            
                            ScheduleDetailView(scheduleDay: scheduleViewViewModel.currentDaySchedule,
                                               horizontalPadding: false,
                                               showBackgroundImage: false)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)


                        if false {
                            Text("For You")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .textAlign(.leading)
                                .padding(.horizontal)

                            Divider()
                                .padding(.bottom, 15)
                                .padding(.horizontal)

                        }

                        AnnoucementBanner(viewModel: todayViewViewModel)
                            .padding(.horizontal)


                }
                .padding(.top, 80)

            }
            .background(Color.platformBackground)
            //.onboardingModal()
            //.aboutFooter()
            //                .onChange(of: selected, perform: { val in
            //                    if val != nil {
            //                        withAnimation {
            //                            todayViewViewModel.showToolbar = false
            //                        }
            //                    }
            //                    else {
            //                        withAnimation {
            //                            todayViewViewModel.showToolbar = true
            //                        }
            //                    }
            //                })
            //                .sheet(isPresented: $todayViewViewModel.showAnnoucement,
            //                       content: {
            //                    VStack {
            //                        if let html = todayViewViewModel.todayAnnoucementHTML {
            //                            WKWebViewRepresentable(HTMLString: html)
            //                        }
            //
            //                    }
            //                    .animation(.easeInOut, value: todayViewViewModel.loadingAnnoucements)
            //                })
            //                .opacity(selected != nil ? 0 : 1)
            //
            //                if let selected = selected {
            //                    BannerDetailView(banner: selected, selected: $selected, animate: animate)
            //                    // sync animate
            //                }
        }
        .onAppear {
            scheduleViewViewModel.objectWillChange.send()
        }
    }
}

//struct TodayHeroView_Previews: PreviewProvider {
////    static var previews: some View {
////        TodayView(scheduleViewViewModel: .mockScheduleView, todayViewViewModel: .mockViewModel)
////    }
//}
