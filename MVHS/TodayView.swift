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
            TodayHeroView(scheduleViewViewModel: scheduleViewViewModel, todayViewViewModel: todayViewViewModel)

            if todayViewViewModel.showToolbar {
                TodayViewHeader(viewModel: scheduleViewViewModel, todayViewModel: todayViewViewModel)
            }

        }
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.appPrimary)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.appSecondary)], for: .normal)
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
                Button(action: {todayViewModel.showEditModal = true}, label: {
                    HStack {
                        Image(systemSymbol: .pencil)
                            .font(Font.subheadline.weight(.semibold))
                            .imageScale(.large)
                            .padding(.trailing, -1)

                        Text("Edit")
                            .font(Font.subheadline.weight(.semibold))
                    }
                    .foregroundColor(.appSecondary)
                })
            }
        }

        .padding(EdgeInsets(top: -3, leading: 20, bottom: 7, trailing: 20))
        .vibrancyEffectStyle(.secondaryLabel)
        .background(BlurEffect().edgesIgnoringSafeArea(.all))
        .blurEffectStyle(.systemThinMaterial)

    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(scheduleViewViewModel: SharedScheduleInformation())
    }
}
