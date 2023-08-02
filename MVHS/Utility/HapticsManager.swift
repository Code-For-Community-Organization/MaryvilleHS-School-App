//
//  HapticsManager.swift
//  MVHS
//
//  Created by Jevon Mao on 12/25/22.
//

import Foundation
import UIKit

struct HapticsManager {
    var notificationFeedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
    var impactFeedbackGenerator: UIImpactFeedbackGenerator?
    init(impactStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        notificationFeedbackGenerator?.prepare()
        impactFeedbackGenerator = UIImpactFeedbackGenerator(style: impactStyle)
        impactFeedbackGenerator?.prepare()
    }
    mutating func notificationImpact(_ type: UINotificationFeedbackGenerator.FeedbackType){
        notificationFeedbackGenerator?.notificationOccurred(type)
        notificationFeedbackGenerator = nil
    }
    mutating func UIFeedbackImpact() {
        impactFeedbackGenerator?.impactOccurred()
        impactFeedbackGenerator = nil
    }
}
