//
//  NewsDetailedView.swift
//  SMHSSchedule
//
//  Created by Jevon Mao on 5/10/21.
//

import SwiftUI
import Kingfisher

struct NewsDetailedView: View {
    @EnvironmentObject var newsViewViewModel: NewsViewViewModel
    @Binding var newsEntry: NewsEntry

    let scheduleDateHelper = ScheduleDateHelper()
    let imageHeight = UIScreen.screenHeight/CGFloat(2)
    var body: some View {
        Group {
            if let text = newsEntry.bodyText {
                WKWebViewRepresentable(HTMLString: text)

            }
            else {
                Text(String(repeating: "placeholder", count: 100))
                    .redacted(reason: .placeholder)
            }
        }
        .onAppear {
            newsEntry.fetchBodyText{text in
                withAnimation {
                    newsEntry.bodyText = text
                }
            }
        }
        .navigationBarItems(trailing: NewsNavigationBarButtons(newsEntry: newsEntry).environmentObject(newsViewViewModel))
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct NewsDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailedView(newsEntry: .constant(.sampleEntries.first!))
            .environmentObject(NewsViewViewModel())

        NavigationView {
            NavigationLink("Detail") {
                NewsDetailedView(newsEntry: .constant(.sampleEntries.first!))
                    .environmentObject(NewsViewViewModel())
            }
        }

    }
}
