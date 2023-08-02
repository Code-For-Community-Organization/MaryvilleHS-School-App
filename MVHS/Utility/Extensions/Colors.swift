//
//  Colors.swift
//  SMHS Schedule
//
//  Created by Jevon Mao on 3/15/21.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

extension Color {
    static var platformBackground: Color {
        Color(UIColor.systemBackground)
    }
    static var platformLabel: Color {
        Color(UIColor.label)
    }
    static var platformSecondaryBackground: Color {
        Color(UIColor.secondarySystemBackground)
    }
    static var platformFill: Color {
        Color(UIColor.systemFill)
    }
    static var platformSecondaryFill: Color {
        Color(UIColor.secondarySystemFill)
    }
    static var platformSecondaryLabel: Color {
        Color(UIColor.secondaryLabel)
    }
    static var platformTertiaryBackground: Color {
        Color(UIColor.tertiarySystemBackground)
    }
    static var platformTertiaryLabel: Color {
        Color(UIColor.tertiaryLabel)
    }

}

#endif

#if canImport(AppKit)
import AppKit

extension Color {
    static var platformBackground: Color {
        Color(NSColor.windowBackgroundColor)
    }
    static var platformLabel: Color {
        Color(NSColor.labelColor)
    }
    static var platformSecondaryBackground: Color {
        Color(NSColor.textBackgroundColor)
    }
    static var platformSecondaryLabel: Color {
        Color(NSColor.secondaryLabelColor)
    }
    static var platformTertiaryLabel: Color {
        Color(NSColor.tertiaryLabelColor)
    }
    
}
#endif
extension Color {
    static var SMBlue: Color {
        Color(hexadecimal: "0736A4")
    }
}


extension Color {
    static var appPrimary: Color {
        Color(hexadecimal: Constants.Color.primaryHex)
    }

    static var appSecondary: Color {
        Color(hexadecimal: Constants.Color.secondaryHex)
    }

    func makeColor(componentDelta: Double) -> Color {
        if let components = self.cgColor?.components {
            return Color(red: components[0] + componentDelta,
                         green: components[1] + componentDelta,
                         blue: components[2] + componentDelta)
        }
        else {
            return self
        }

    }
}
