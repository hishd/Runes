//
//  Color+luminance.swift
//  Runes
//
//  Created by Michael Long on 11/7/24.
//

import SwiftUI

extension Color {
    func luminance() -> Double {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }
}

extension Color {
    func isLight() -> Bool {
        return luminance() > 0.5
    }
}

extension Color {
    /// Function returns black if background color is light, or white if background color is dark.
    /// ```swift
    ///    Text(team.name)
    ///        .font(.largeTitle)
    ///        .background(team.color)
    ///        .foregroundStyle(team.color.adaptedTextColor())
    /// ```
    func adaptiveTextColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
}
