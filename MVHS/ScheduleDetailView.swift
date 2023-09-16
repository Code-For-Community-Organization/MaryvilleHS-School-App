//
//  ScheduleCardView.swift
//  SMHS Schedule
//
//  Created by Jevon Mao on 3/15/21.
//

import SwiftUI
import SFSafeSymbols
import SwiftUIVisualEffects

struct ScheduleDetailView: View {
    @Binding var selection: ScheduleCategory
    var body: some View {
        switch selection {
        case .regular:
            Text("""
8:25 - 9:55 | First Period
9:55 - 10:10 | Break
10:10 - 11:40 | Second Period
11:47 - 1:48 | Third Period

**A LUNCH**
11:43 - 12:13 | Lunch
12:17 - 1:48 | Class

**B LUNCH**
11:47 - 12:13 | Class
12:13 - 12:43 | Lunch
12:46 - 1:48 | Class

**C LUNCH**
11:47 - 12:48 | Class
12:48 - 1:18 | Lunch
1:21 - 1:48 | Class

**D LUNCH**
11:47 - 1:18 | Class
1:18 - 1:48 | Lunch
1:55 - 3:25 | Fourth Period
""")
        case .morning:
            Text("""
8:25 - 9:45 | First Period
9:50 - 10:35 | Activity Period
10:35 - 11:55 | Second Period
12:00 - 2:00 | Third Period

**A LUNCH**
11:55 - 12:25 | Lunch
12:30 - 2:00 | Class

**B LUNCH**
12:00 - 12:25 | Class
12:25 - 12:55 | Lunch
12:58 - 2:00 | Class

**C LUNCH**
12:00 - 1:00 | Class
1:00 - 1:30 | Lunch
1:33 - 2:00 | Class

**D LUNCH**
12:00 - 1:30 | Class
1:30 - 2:00 | Lunch
2:05 - 3:25 | Fourth Period
""")
        case .afternoon:
            Text("""
8:25 - 9:40 | First Period
9:45 - 11:05 | Second Period
11:10 - 1:15 | Third Period

**A LUNCH**
11:05 - 11:35 | Lunch
11:40 - 1:15 | Class

**B LUNCH**
11:10 - 11:35 | Class
11:35 - 12:05 | Lunch
12:10 - 1:15 | Class

**C LUNCH**
11:10 - 12:15 | Class
12:15 - 12:45 | Lunch
12:50 - 1:15 | Class

**D LUNCH**
11:10 - 12:45 | Class
12:45 - 1:15 | Lunch
1:20 - 2:35 | Fourth Period
2:40 - 3:25 | Activity Period
""")
        case .delay:
            Text("""
9:25 - 10:40 | First Period
10:45 - 12:00 | Second Period
12:05 - 2:05 | Third Period

**A LUNCH**
12:00 - 12:30 | Lunch
12:33 - 2:05 | Class

**B LUNCH**
12:05 - 12:30 | Class
12:30 - 1:00 | Lunch
1:03- 2:05 | Class

**C LUNCH**
12:05 - 1:00 | Class
1:05 - 1:35 | Lunch
1:38 - 2:05 | Class

**D LUNCH**
12:05 - 1:35 | Class
1:35 - 2:05 | Lunch
2:10 - 3:25 | Fourth Period
""")
        }
    }
    

}

