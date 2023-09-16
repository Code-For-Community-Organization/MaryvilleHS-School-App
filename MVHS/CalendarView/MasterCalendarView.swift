//
//  MasterCalendarView.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 6/4/21.
//

import SwiftUI
import ElegantCalendar

struct MasterCalendarView: View {
    @State private var orientationValue: Int?
    @State private var hapticsManager = HapticsManager(impactStyle: .light)
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject private var calendarManager: ElegantCalendarManager
    @ObservedObject private var calendarViewModel: MasterCalendarViewModel
    init(calendarViewModel: MasterCalendarViewModel) {
        self.calendarViewModel = calendarViewModel
        self.calendarManager = ElegantCalendarManager(
            configuration: CalendarConfiguration(startDate: calendarViewModel.getStartDate(),
                                                 endDate: calendarViewModel.getEndDate()),
            initialMonth: Date())
    }
    var body: some View {
//        ZStack(alignment: .bottom) {
//            ElegantCalendarView(calendarManager: calendarManager)
//                .theme(.init(primary: .appPrimary))
//            Button(action: {
//                hapticsManager.UIFeedbackImpact()
//                presentationMode.wrappedValue.dismiss()
//            }, label: {
//                Image(systemSymbol: .xmark)
//                    .foregroundColor(Color.platformSecondaryLabel)
//                    .padding(10)
//                    .background(Color.platformSecondaryBackground)
//                    .clipShape(Circle())
//            })
//            .padding(.bottom, 30)
//        }
        ElegantCalendarView(calendarManager: calendarManager)
            .theme(.init(primary: .appPrimary))
            .blur(radius: calendarViewModel.isLoading ? 15 : 0)
            .disabled(calendarViewModel.isLoading)
            .overlay (
                ZStack {
                    if calendarViewModel.isLoading {
                        ProgressView("Loading the magic... 🌟")
                            .font(.title3)
                    }
                }
            )


        .onAppear {
            withAnimation {
                calendarViewModel.isLoading = true
                calendarViewModel.reloadData {
                    calendarManager.datasource = self
                    calendarManager.delegate = self
                    DispatchQueue.main.async {
                        calendarManager.datasource = self
                        //AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                        orientationValue = UIDevice.current.orientation.rawValue
                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                        UINavigationController.attemptRotationToDeviceOrientation()
                    }
                    calendarViewModel.isLoading = false
                }
            }

        }
        .onDisappear {
            DispatchQueue.main.async {
                    //AppDelegate.orientationLock = UIInterfaceOrientationMask.all
                    UIDevice.current.setValue(orientationValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
            }
        }
    }

}

extension MasterCalendarView: ElegantCalendarDataSource {
    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
        calendarViewModel.calendarManager.getOpacity(forDay: date)
    }

    func calendar(canSelectDate date: Date) -> Bool {true}

    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView
    {
        SelectedDateView(events: calendarViewModel.calendarManager.days[date]?.events ?? [])
            .typeErased()
    }
}

extension MasterCalendarView: ElegantCalendarDelegate {
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func formatMonth(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMN"
        return dateFormatter.string(from: date)
    }
    
    func calendar(didSelectDay date: Date) {
    }
    
    func calendar(willDisplayMonth date: Date) {
    }
}
