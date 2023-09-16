//
//  TodayView.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import SwiftUI
import SFSafeSymbols
import SwiftUIVisualEffects

struct TodayView: View {
    @StateObject var scheduleViewViewModel: SharedScheduleInformation
    @StateObject var todayViewViewModel = TodayViewViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            TodayHeroView(todayViewViewModel: todayViewViewModel)

            if todayViewViewModel.showToolbar {
                TodayViewHeader(viewModel: scheduleViewViewModel, todayViewModel: todayViewViewModel)
            }

        }
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.appPrimary)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.black)], for: .normal)
        }
        .onDisappear {
            todayViewViewModel.showNetworkError = true
        }
    }
}


struct TodayViewHeader: View {
    @StateObject var viewModel: SharedScheduleInformation
    @StateObject var todayViewModel: TodayViewViewModel
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(viewModel.dateHelper.todayDateDescription)
                        .fontWeight(.semibold)
                        .textAlign(.leading)
                        .textCase(.uppercase)
                        .vibrancyEffect()

                    Text(viewModel.dateHelper.currentWeekday)
                        .font(.title)
                        .fontWeight(.bold)
                        .textAlign(.leading)
                    //.foregroundColor(.platformSecondaryLabel)

                }
                Spacer()
                Image("MVHSLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 50)

            }
        }

        .padding(EdgeInsets(top: -3, leading: 20, bottom: 7, trailing: 20))
        .background(.thickMaterial)

    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(scheduleViewViewModel: SharedScheduleInformation())
    }
}
