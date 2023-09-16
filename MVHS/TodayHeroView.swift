//
//  TodayHeroView.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import SwiftUI
import SFSafeSymbols

struct TodayHeroView: View {
    @StateObject var todayViewViewModel: TodayViewViewModel
    @Environment(\.openURL) var openURL
    @Namespace var animate
    
    var body: some View {
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .clipped()
//                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    VStack {
                        Text("Detailed Schedule")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .textAlign(.leading)
                                .padding(.top, 5)
                                .foregroundStyle(.primary)
                        
                        Picker("", selection: $todayViewViewModel.selectionMode){
                            Text("Regular")
                                .tag(ScheduleCategory.regular)
                            Text("Morning")
                                .tag(ScheduleCategory.morning)
                            Text("Afternoon")
                                .tag(ScheduleCategory.afternoon)
                            Text("Delayed")
                                .tag(ScheduleCategory.delay)
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .foregroundStyle(.primary)
                        .padding(.bottom, 40)

                        Divider()
                            .padding(.bottom, 5)

                        ScheduleDetailView(selection: $todayViewViewModel.selectionMode)
                            .frame(maxWidth: .infinity, alignment: .leading)

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

//                        AnnoucementBanner(viewModel: todayViewViewModel)
//                            .padding(.horizontal)


                }
                .padding(.top, 80)

            }
            .background(.ultraThinMaterial)
            .background(
                ZStack {
                    Image("MVHSPhoto")
            })

    }
}

//struct TodayHeroView_Previews: PreviewProvider {
////    static var previews: some View {
////        TodayView(scheduleViewViewModel: .mockScheduleView, todayViewViewModel: .mockViewModel)
////    }
//}
